import SwiftUI

struct PunchTimelineView: View {
    var records: [PunchRecord]
    var limit: Int?
    var showsSource = true

    private var displayRecords: [PunchRecord] {
        let sorted = records.sorted { $0.timestamp > $1.timestamp }
        guard let limit else { return sorted }
        return Array(sorted.prefix(limit))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if displayRecords.isEmpty {
                Text("Nenhuma batida registrada hoje.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)
            } else {
                ForEach(displayRecords) { record in
                    PunchTimelineRow(record: record, showsSource: showsSource)
                }
            }
        }
    }
}

private struct PunchTimelineRow: View {
    var record: PunchRecord
    var showsSource: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: record.kind.systemImage)
                .font(.headline)
                .foregroundStyle(record.kind.tint)
                .frame(width: 28, height: 28)
                .background(record.kind.tint.opacity(0.12), in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(record.kind.title)
                    .font(.subheadline.weight(.semibold))
                    .lineLimit(1)

                if showsSource {
                    Label(record.source.title, systemImage: record.source.systemImage)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: 0)

            Text(record.timestamp.pontoTimeString)
                .font(.callout.monospacedDigit().weight(.semibold))
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
