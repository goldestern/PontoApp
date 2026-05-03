import SwiftUI

extension PunchKind {
    var tint: Color {
        switch self {
        case .clockIn:
            return .green
        case .breakStart:
            return .orange
        case .breakEnd:
            return .blue
        case .clockOut:
            return .red
        }
    }
}

extension ShiftStatus {
    var tint: Color {
        switch self {
        case .notStarted:
            return .secondary
        case .working:
            return .green
        case .onBreak:
            return .orange
        case .finished:
            return .blue
        }
    }
}
