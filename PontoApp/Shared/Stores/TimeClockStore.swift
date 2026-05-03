import Combine
import Foundation

@MainActor
final class TimeClockStore: ObservableObject {
    @Published private(set) var records: [PunchRecord]
    @Published private(set) var lastSyncDate: Date?

    private let source: DeviceSource
    private let storage: PunchStorage
    private let sync: TimeClockSyncing
    private let calendar: Calendar
    private var deletedRecordIDs: Set<UUID>

    init(
        source: DeviceSource,
        storage: PunchStorage = PunchStorage(),
        sync: TimeClockSyncing = WatchConnectivitySync(),
        calendar: Calendar = .current
    ) {
        self.source = source
        self.storage = storage
        self.sync = sync
        self.calendar = calendar
        let archive = storage.loadArchive()
        self.records = archive.records
        self.deletedRecordIDs = archive.deletedRecordIDs

        sync.onArchiveReceived = { [weak self] incomingArchive in
            Task { @MainActor in
                self?.merge(incomingArchive)
            }
        }
        sync.activate()
    }

    var todayRecords: [PunchRecord] {
        records
            .filter { calendar.isDateInToday($0.timestamp) }
            .sorted { $0.timestamp < $1.timestamp }
    }

    var status: ShiftStatus {
        ShiftStatus.resolve(from: todayRecords)
    }

    var summary: WorkdaySummary {
        WorkdaySummary.calculate(from: todayRecords)
    }

    var nextActions: [PunchKind] {
        status.nextActions
    }

    func punch(_ kind: PunchKind) {
        let record = PunchRecord(kind: kind, source: source)
        records.append(record)
        records.sort { $0.timestamp < $1.timestamp }
        persistAndSync()
    }

    func clearAll() {
        deletedRecordIDs.formUnion(records.map(\.id))
        records.removeAll()
        persistAndSync()
    }

    func clearToday() {
        let removedRecords = records.filter { calendar.isDateInToday($0.timestamp) }
        deletedRecordIDs.formUnion(removedRecords.map(\.id))
        records.removeAll { calendar.isDateInToday($0.timestamp) }
        persistAndSync()
    }

    private func merge(_ incomingArchive: PunchArchive) {
        let previousDeletedRecordIDs = deletedRecordIDs
        deletedRecordIDs.formUnion(incomingArchive.deletedRecordIDs)

        var merged = Dictionary(
            uniqueKeysWithValues: records
                .filter { !deletedRecordIDs.contains($0.id) }
                .map { ($0.id, $0) }
        )

        for record in incomingArchive.records where !deletedRecordIDs.contains(record.id) {
            merged[record.id] = record
        }

        let sorted = merged.values.sorted { $0.timestamp < $1.timestamp }
        guard sorted != records || previousDeletedRecordIDs != deletedRecordIDs else { return }

        records = sorted
        storage.save(currentArchive)
        lastSyncDate = Date()
    }

    private func persistAndSync() {
        let archive = currentArchive
        storage.save(archive)
        lastSyncDate = Date()
        sync.send(archive: archive)
    }

    private var currentArchive: PunchArchive {
        PunchArchive(records: records, deletedRecordIDs: deletedRecordIDs)
    }
}
