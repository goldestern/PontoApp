import SwiftUI

struct DailySummaryView: View {
    var summary: WorkdaySummary

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            SummaryMetricView(
                title: "Trabalhado",
                value: summary.workedTime.pontoDurationString,
                systemImage: "clock.fill"
            )

            SummaryMetricView(
                title: "Pausas",
                value: summary.breakTime.pontoDurationString,
                systemImage: "cup.and.saucer.fill"
            )

            SummaryMetricView(
                title: "Entrada",
                value: summary.firstClockIn?.pontoTimeString ?? "--:--",
                systemImage: "arrow.right.circle.fill"
            )

            SummaryMetricView(
                title: "Saída",
                value: summary.lastClockOut?.pontoTimeString ?? "--:--",
                systemImage: "arrow.left.circle.fill"
            )
        }
    }
}
