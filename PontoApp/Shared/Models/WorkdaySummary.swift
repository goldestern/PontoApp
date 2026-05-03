import Foundation

struct WorkdaySummary: Equatable {
    var workedTime: TimeInterval
    var breakTime: TimeInterval
    var firstClockIn: Date?
    var lastClockOut: Date?

    var balanceText: String {
        workedTime.pontoDurationString
    }

    static let empty = WorkdaySummary(
        workedTime: 0,
        breakTime: 0,
        firstClockIn: nil,
        lastClockOut: nil
    )

    static func calculate(from records: [PunchRecord], now: Date = Date()) -> WorkdaySummary {
        enum RunningState {
            case off
            case working
            case onBreak
        }

        let sorted = records.sorted { $0.timestamp < $1.timestamp }
        guard !sorted.isEmpty else { return .empty }

        var state = RunningState.off
        var cursor: Date?
        var workedTime: TimeInterval = 0
        var breakTime: TimeInterval = 0
        var firstClockIn: Date?
        var lastClockOut: Date?

        for record in sorted {
            if let cursor {
                let elapsed = max(0, record.timestamp.timeIntervalSince(cursor))
                switch state {
                case .off:
                    break
                case .working:
                    workedTime += elapsed
                case .onBreak:
                    breakTime += elapsed
                }
            }

            switch record.kind {
            case .clockIn:
                if firstClockIn == nil {
                    firstClockIn = record.timestamp
                }
                state = .working
            case .breakStart:
                state = .onBreak
            case .breakEnd:
                state = .working
            case .clockOut:
                lastClockOut = record.timestamp
                state = .off
            }

            cursor = record.timestamp
        }

        if let cursor {
            let elapsed = max(0, now.timeIntervalSince(cursor))
            switch state {
            case .off:
                break
            case .working:
                workedTime += elapsed
            case .onBreak:
                breakTime += elapsed
            }
        }

        return WorkdaySummary(
            workedTime: workedTime,
            breakTime: breakTime,
            firstClockIn: firstClockIn,
            lastClockOut: lastClockOut
        )
    }
}
