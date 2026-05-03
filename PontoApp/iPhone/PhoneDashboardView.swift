import SwiftUI

struct PhoneDashboardView: View {
    @EnvironmentObject private var store: TimeClockStore
    @State private var showingClearToday = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    StatusOverviewView(status: store.status, summary: store.summary)

                    actionSection

                    section("Resumo de hoje") {
                        DailySummaryView(summary: store.summary)
                    }

                    section("Histórico de hoje") {
                        PunchTimelineView(records: store.todayRecords)
                    }

                    SyncFooterView(lastSyncDate: store.lastSyncDate)
                        .padding(.top, 4)
                }
                .padding()
            }
            .navigationTitle("Ponto")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingClearToday = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .disabled(store.todayRecords.isEmpty)
                }

                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        PhoneHistoryView()
                            .environmentObject(store)
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                }
            }
            .confirmationDialog("Apagar registros de hoje?", isPresented: $showingClearToday) {
                Button("Apagar hoje", role: .destructive) {
                    store.clearToday()
                }
            } message: {
                Text("Essa ação remove apenas as batidas registradas hoje neste aparelho e sincroniza a alteração.")
            }
        }
    }

    private var actionSection: some View {
        section("Registrar ponto") {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(store.nextActions) { kind in
                    PunchActionButton(kind: kind) {
                        store.punch(kind)
                    }
                }
            }
        }
    }

    private func section<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)

            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
