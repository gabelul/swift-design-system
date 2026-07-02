import SwiftUI

/// Catalog view for the TimelineRow component
struct TimelineRowCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "TimelineRow") {
            CatalogOverview(description: "One row in a chronological feed — an activity log, progress steps, or change history. Stacking rows in a VStack(spacing: 0) produces a continuous connector line down the timeline.")

            SectionCard(title: "Status markers") {
                VStack(spacing: 0) {
                    TimelineRow(status: .success, isFirst: true) {
                        entry(title: "Searched the web", detail: "query: SwiftUI state management")
                    }
                    TimelineRow(status: .success) {
                        entry(title: "Fetched 3 pages", detail: "docs.swift.org and others")
                    }
                    TimelineRow(status: .running) {
                        entry(title: "Generating summary…", detail: nil)
                    }
                    TimelineRow(status: .pending, isLast: true) {
                        entry(title: "Compiling answer", detail: nil)
                    }
                }
            }

            SectionCard(title: "Custom markers") {
                VStack(spacing: 0) {
                    TimelineRow(isFirst: true) {
                        IconBadge(systemName: "magnifyingglass", size: .small)
                    } content: {
                        entry(title: "Research Agent", detail: "Collected 5 sources")
                    }
                    TimelineRow {
                        IconBadge(systemName: "photo.on.rectangle.angled", size: .small)
                    } content: {
                        entry(title: "Visualizer", detail: "Generated chart image")
                    }
                    TimelineRow(isLast: true) {
                        IconBadge(systemName: "paintbrush", size: .small)
                    } content: {
                        entry(title: "A2UI Agent", detail: "Rendered surface")
                    }
                }
            }

            SectionCard(title: "Rich content") {
                VStack(spacing: 0) {
                    TimelineRow(status: .success, isFirst: true) {
                        VStack(alignment: .leading, spacing: spacing.xs) {
                            entry(title: "Verified sources", detail: nil)
                            HStack(spacing: spacing.xs) {
                                Chip("4 fetched", systemImage: "checkmark")
                                    .chipStyle(.filled)
                                    .chipSize(.small)
                                    .foregroundColor(.green)
                                Chip("1 failed", systemImage: "xmark")
                                    .chipStyle(.filled)
                                    .chipSize(.small)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    TimelineRow(status: .success, isLast: true) {
                        entry(title: "Done", detail: nil)
                    }
                }
            }
        }
    }

    private func entry(title: String, detail: String?) -> some View {
        VStack(alignment: .leading, spacing: spacing.xxs) {
            Text(title).typography(.bodyMedium).foregroundStyle(colors.onSurface)
            if let detail {
                Text(detail).typography(.labelSmall).foregroundStyle(colors.onSurfaceVariant)
            }
        }
    }
}

#Preview {
    NavigationStack {
        TimelineRowCatalogView()
            .theme(ThemeProvider())
    }
}
