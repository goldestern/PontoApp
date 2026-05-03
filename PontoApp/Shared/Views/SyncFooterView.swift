import SwiftUI

struct SyncFooterView: View {
    var lastSyncDate: Date?

    var body: some View {
        Label {
            Text(lastSyncDate.map { "Sincronizado às \($0.pontoTimeString)" } ?? "Aguardando sincronização")
        } icon: {
            Image(systemName: "arrow.triangle.2.circlepath")
        }
        .font(.caption)
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
