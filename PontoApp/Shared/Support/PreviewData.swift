import Foundation

enum PreviewData {
    static var records: [PunchRecord] {
        let calendar = Calendar.current
        let now = Date()
        let start = calendar.date(bySettingHour: 8, minute: 4, second: 0, of: now) ?? now
        let breakStart = calendar.date(bySettingHour: 12, minute: 1, second: 0, of: now) ?? now
        let breakEnd = calendar.date(bySettingHour: 13, minute: 0, second: 0, of: now) ?? now

        return [
            PunchRecord(kind: .clockIn, timestamp: start, source: .iphone),
            PunchRecord(kind: .breakStart, timestamp: breakStart, source: .watch),
            PunchRecord(kind: .breakEnd, timestamp: breakEnd, source: .watch)
        ]
    }
}
