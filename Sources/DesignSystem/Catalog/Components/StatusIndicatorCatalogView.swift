import SwiftUI

/// Catalog view for the StatusIndicator component
struct StatusIndicatorCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "StatusIndicator") {
            CatalogOverview(description: "An indicator representing asynchronous task state — pending, running, success, failure, canceled — as a single glyph. Used as a trailing element in list rows or as a timeline marker.")

            SectionCard(title: "Statuses") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    statusRow(.pending, label: "pending", description: "Waiting to start")
                    Divider()
                    statusRow(.running, label: "running", description: "In progress (ProgressView)")
                    Divider()
                    statusRow(.success, label: "success", description: "Completed successfully (success color)")
                    Divider()
                    statusRow(.failure, label: "failure", description: "Failed (error color)")
                    Divider()
                    statusRow(.canceled, label: "canceled", description: "Canceled")
                }
            }

            SectionCard(title: "Used in a list row") {
                VStack(spacing: spacing.sm) {
                    exampleRow(title: "Research Agent", status: .success)
                    exampleRow(title: "Script Runner Agent", status: .running)
                    exampleRow(title: "Visualizer", status: .pending)
                }
            }
        }
    }

    private func statusRow(_ kind: StatusKind, label: String, description: String) -> some View {
        HStack(spacing: spacing.md) {
            StatusIndicator(kind)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: spacing.xxs) {
                Text(label).typography(.labelLarge).foregroundStyle(colors.onSurface)
                Text(description).typography(.bodySmall).foregroundStyle(colors.onSurfaceVariant)
            }
            Spacer()
        }
    }

    private func exampleRow(title: String, status: StatusKind) -> some View {
        HStack {
            Text(title).typography(.bodyMedium).foregroundStyle(colors.onSurface)
            Spacer()
            StatusIndicator(status)
        }
        .padding(spacing.md)
        .background(colors.elevatedSurface, in: RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    NavigationStack {
        StatusIndicatorCatalogView()
            .theme(ThemeProvider())
    }
}
