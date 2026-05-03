import Foundation

enum PunchKind: String, CaseIterable, Codable, Identifiable {
    case clockIn
    case breakStart
    case breakEnd
    case clockOut

    var id: String { rawValue }

    var title: String {
        switch self {
        case .clockIn:
            return "Entrada"
        case .breakStart:
            return "Iniciar pausa"
        case .breakEnd:
            return "Voltar da pausa"
        case .clockOut:
            return "Saída"
        }
    }

    var shortTitle: String {
        switch self {
        case .clockIn:
            return "Entrar"
        case .breakStart:
            return "Pausa"
        case .breakEnd:
            return "Voltar"
        case .clockOut:
            return "Sair"
        }
    }

    var systemImage: String {
        switch self {
        case .clockIn:
            return "play.circle.fill"
        case .breakStart:
            return "pause.circle.fill"
        case .breakEnd:
            return "arrow.clockwise.circle.fill"
        case .clockOut:
            return "stop.circle.fill"
        }
    }
}
