import SwiftUI

@main
struct PontoWatchApp: App {
    @StateObject private var store = TimeClockStore(source: .watch)

    var body: some Scene {
        WindowGroup {
            WatchDashboardView()
                .environmentObject(store)
        }
    }
}
