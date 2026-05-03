import Foundation

struct PunchArchive: Codable, Equatable {
    var records: [PunchRecord]
    var deletedRecordIDs: Set<UUID>

    init(records: [PunchRecord], deletedRecordIDs: Set<UUID> = []) {
        self.records = records
        self.deletedRecordIDs = deletedRecordIDs
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        records = try container.decode([PunchRecord].self, forKey: .records)
        deletedRecordIDs = try container.decodeIfPresent(Set<UUID>.self, forKey: .deletedRecordIDs) ?? []
    }
}

final class PunchStorage {
    private let defaults: UserDefaults
    private let key: String
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(defaults: UserDefaults = .standard, key: String = "br.com.ponto.records.v1") {
        self.defaults = defaults
        self.key = key

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        self.encoder = encoder

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    func loadArchive() -> PunchArchive {
        guard let data = defaults.data(forKey: key) else {
            return PunchArchive(records: [])
        }

        do {
            var archive = try decoder.decode(PunchArchive.self, from: data)
            archive.records.sort { $0.timestamp < $1.timestamp }
            return archive
        } catch {
            defaults.removeObject(forKey: key)
            return PunchArchive(records: [])
        }
    }

    func save(_ archive: PunchArchive) {
        do {
            let sortedRecords = archive.records.sorted { $0.timestamp < $1.timestamp }
            let normalizedArchive = PunchArchive(
                records: sortedRecords,
                deletedRecordIDs: archive.deletedRecordIDs
            )
            let data = try encoder.encode(normalizedArchive)
            defaults.set(data, forKey: key)
        } catch {
            assertionFailure("Failed to persist punch records: \(error)")
        }
    }
}
