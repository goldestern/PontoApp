import SwiftUI

struct StatusOverviewView: View {
    var status: ShiftStatus
    var summary: WorkdaySummary
    var compact = false

    var body: some View {
        VStack(alignment: .leading, spacing: compact ? 10 : 16) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: status.systemImage)
                    .font(compact ? .title3 : .title2)
                    .foregroundStyle(status.tint)
                    .frame(width: compact ? 28 : 36, height: compact ? 28 : 36)

                VStack(alignment: .leading, spacing: 4) {
                    Text(status.title)
                        .font(compact ? .headline : .title3.weight(.semibold))
                        .lineLimit(2)

                    Text(status.detail)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                Spacer(minLength: 0)
            }

            HStack(spacing: 10) {
                SummaryMetricView(
                    title: "Hoje",
                    value: summary.workedTime.pontoDurationString,
                    systemImage: "timer"
                )

                if !compact {
                    SummaryMetricView(
                        title: "Pausa",
                        value: summary.breakTime.pontoDurationString,
                        systemImage: "pause.fill"
                    )
                }
            }
        }
        .padding(compact ? 12 : 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(status.tint.opacity(0.25), lineWidth: 1)
        }
    }
}

struct SummaryMetricView: View {
    var title: String
    var value: String
    var systemImage: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .textCase(.uppercase)

                Text(value)
                    .font(.callout.monospacedDigit().weight(.semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color.primary.opacity(0.04), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
