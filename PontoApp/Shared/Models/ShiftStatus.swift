import Foundation

enum ShiftStatus: Equatable {
    case notStarted
    case working(since: Date)
    case onBreak(since: Date)
    case finished(at: Date)

    var title: String {
        switch self {
        case .notStarted:
            return "Fora do expediente"
        case .working:
            return "Trabalhando"
        case .onBreak:
            return "Em pausa"
        case .finished:
            return "Expediente encerrado"
        }
    }

    var detail: String {
        switch self {
        case .notStarted:
            return "Registre a entrada para iniciar o dia."
        case .working(let since):
            return "Desde \(since.pontoTimeString)"
        case .onBreak(let since):
            return "Pausa desde \(since.pontoTimeString)"
        case .finished(let at):
            return "Saída registrada às \(at.pontoTimeString)"
        }
    }

    var systemImage: String {
        switch self {
        case .notStarted:
            return "moon.zzz.fill"
        case .working:
            return "briefcase.fill"
        case .onBreak:
            return "cup.and.saucer.fill"
        case .finished:
            return "checkmark.seal.fill"
        }
    }

    var nextActions: [PunchKind] {
        switch self {
        case .notStarted, .finished:
            return [.clockIn]
        case .working:
            return [.breakStart, .clockOut]
        case .onBreak:
            return [.breakEnd]
        }
    }

    static func resolve(from records: [PunchRecord]) -> ShiftStatus {
        guard let last = records.sorted(by: { $0.timestamp < $1.timestamp }).last else {
            return .notStarted
        }

        switch last.kind {
        case .clockIn, .breakEnd:
            return .working(since: last.timestamp)
        case .breakStart:
            return .onBreak(since: last.timestamp)
        case .clockOut:
            return .finished(at: last.timestamp)
        }
    }
}
