import Foundation

enum PontoFormatters {
    static let locale = Locale(identifier: "pt_BR")

    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
}

extension Date {
    var pontoTimeString: String {
        PontoFormatters.time.string(from: self)
    }

    var pontoDayString: String {
        PontoFormatters.day.string(from: self)
    }
}

extension TimeInterval {
    var pontoDurationString: String {
        let totalMinutes = max(0, Int(self / 60))
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        return "\(hours)h \(String(format: "%02d", minutes))min"
    }
}
