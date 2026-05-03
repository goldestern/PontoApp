import SwiftUI

@main
struct PontoIPhoneApp: App {
    @StateObject private var store = TimeClockStore(source: .iphone)

    var body: some Scene {
        WindowGroup {
            PhoneDashboardView()
                .environmentObject(store)
        }
    }
}
