import SwiftUI

struct PhoneHistoryView: View {
    @EnvironmentObject private var store: TimeClockStore
    @State private var showingClearAll = false

    private var groupedRecords: [(day: Date, records: [PunchRecord])] {
        let calendar = Calendar.current
        let groups = Dictionary(grouping: store.records) { record in
            calendar.startOfDay(for: record.timestamp)
        }

        return groups.keys
            .sorted(by: >)
            .map { day in
                (day, groups[day, default: []].sorted { $0.timestamp > $1.timestamp })
            }
    }

    var body: some View {
        List {
            if groupedRecords.isEmpty {
                Text("Nenhum registro ainda.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(groupedRecords, id: \.day) { group in
                    Section(group.day.pontoDayString) {
                        ForEach(group.records) { record in
                            historyRow(record)
                        }
                    }
                }
            }
        }
        .navigationTitle("Histórico")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(role: .destructive) {
                    showingClearAll = true
                } label: {
                    Image(systemName: "trash")
                }
                .disabled(store.records.isEmpty)
            }
        }
        .confirmationDialog("Apagar todo o histórico?", isPresented: $showingClearAll) {
            Button("Apagar tudo", role: .destructive) {
                store.clearAll()
            }
        } message: {
            Text("Essa ação remove todas as batidas salvas neste aparelho e sincroniza a alteração.")
        }
    }

    private func historyRow(_ record: PunchRecord) -> some View {
        HStack(spacing: 12) {
            Image(systemName: record.kind.systemImage)
                .foregroundStyle(record.kind.tint)
                .frame(width: 26)

            VStack(alignment: .leading, spacing: 2) {
                Text(record.kind.title)
                    .font(.body.weight(.medium))

                Label(record.source.title, systemImage: record.source.systemImage)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(record.timestamp.pontoTimeString)
                .font(.body.monospacedDigit())
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
