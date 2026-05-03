import Foundation

enum DeviceSource: String, CaseIterable, Codable, Identifiable {
    case iphone
    case watch

    var id: String { rawValue }

    var title: String {
        switch self {
        case .iphone:
            return "iPhone"
        case .watch:
            return "Apple Watch"
        }
    }

    var systemImage: String {
        switch self {
        case .iphone:
            return "iphone"
        case .watch:
            return "applewatch"
        }
    }
}
