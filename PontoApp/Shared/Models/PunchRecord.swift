import Foundation

struct PunchRecord: Identifiable, Codable, Hashable {
    let id: UUID
    var kind: PunchKind
    var timestamp: Date
    var source: DeviceSource
    var note: String?

    init(
        id: UUID = UUID(),
        kind: PunchKind,
        timestamp: Date = Date(),
        source: DeviceSource,
        note: String? = nil
    ) {
        self.id = id
        self.kind = kind
        self.timestamp = timestamp
        self.source = source
        self.note = note
    }
}
