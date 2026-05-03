import SwiftUI

struct PunchActionButton: View {
    var kind: PunchKind
    var compact = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Label {
                Text(compact ? kind.shortTitle : kind.title)
                    .font(compact ? .callout.weight(.semibold) : .headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            } icon: {
                Image(systemName: kind.systemImage)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, compact ? 4 : 8)
        }
        .buttonStyle(.borderedProminent)
        .tint(kind.tint)
    }
}
