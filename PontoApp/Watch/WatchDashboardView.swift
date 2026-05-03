import SwiftUI

struct WatchDashboardView: View {
    @EnvironmentObject private var store: TimeClockStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    StatusOverviewView(
                        status: store.status,
                        summary: store.summary,
                        compact: true
                    )

                    VStack(spacing: 8) {
                        ForEach(store.nextActions) { kind in
                            PunchActionButton(kind: kind, compact: true) {
                                store.punch(kind)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hoje")
                            .font(.headline)

                        PunchTimelineView(
                            records: store.todayRecords,
                            limit: 4,
                            showsSource: false
                        )
                    }

                    SyncFooterView(lastSyncDate: store.lastSyncDate)
                }
                .padding(.horizontal, 2)
            }
            .navigationTitle("Ponto")
        }
    }
}
