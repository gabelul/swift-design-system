import SwiftUI

/// TimelineRow Component
///
/// A single row in a chronological feed (activity log, progress steps, change history, etc.).
/// Places a marker (status or arbitrary icon) with a vertical connector line on the left,
/// and arbitrary content on the right. Stacking rows in a `VStack(spacing: 0)` turns the
/// connector lines into a continuous timeline.
///
/// ## Basic Usage Examples
/// ```swift
/// VStack(spacing: 0) {
///     TimelineRow(status: .success, isFirst: true) {
///         Text("Searched the web").typography(.bodyMedium)
///     }
///     TimelineRow(status: .running) {
///         Text("Fetching pages…").typography(.bodyMedium)
///     }
///     TimelineRow(status: .pending, isLast: true) {
///         Text("Summary").typography(.bodyMedium)
///     }
/// }
/// ```
///
/// The marker can also be swapped for any view:
/// ```swift
/// TimelineRow(isFirst: true) {
///     IconBadge(systemName: "magnifyingglass", size: .small)
/// } content: {
///     Text("Research agent ran a search")
/// }
/// ```
public struct TimelineRow<Marker: View, Content: View>: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    private let isFirst: Bool
    private let isLast: Bool
    private let markerColumnWidth: CGFloat
    private let marker: Marker
    private let content: Content

    /// Creates a timeline row with a custom marker
    /// - Parameters:
    ///   - isFirst: First row (doesn't draw the top connector line)
    ///   - isLast: Last row (doesn't draw the bottom connector line)
    ///   - markerColumnWidth: Width of the marker column (default 32pt). Keep consistent across consecutive rows
    ///   - marker: Marker view placed in the left column
    ///   - content: The row's body
    public init(
        isFirst: Bool = false,
        isLast: Bool = false,
        markerColumnWidth: CGFloat = 32,
        @ViewBuilder marker: () -> Marker,
        @ViewBuilder content: () -> Content
    ) {
        self.isFirst = isFirst
        self.isLast = isLast
        self.markerColumnWidth = markerColumnWidth
        self.marker = marker()
        self.content = content()
    }

    public var body: some View {
        HStack(alignment: .top, spacing: spacing.sm) {
            markerColumn
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, isLast ? 0 : spacing.md)
        }
        // Prevent the connector line (maxHeight: .infinity) from stretching past the row's natural height
        .fixedSize(horizontal: false, vertical: true)
    }

    private var markerColumn: some View {
        VStack(spacing: spacing.xxs) {
            connector(hidden: isFirst)
                .frame(height: spacing.xs)
            marker
            connector(hidden: isLast)
                .frame(maxHeight: .infinity)
        }
        .frame(width: markerColumnWidth)
    }

    @ViewBuilder
    private func connector(hidden: Bool) -> some View {
        RoundedRectangle(cornerRadius: connectorWidth / 2)
            .fill(colors.outlineVariant)
            .frame(width: connectorWidth)
            .opacity(hidden ? 0 : 1)
    }

    private var connectorWidth: CGFloat { 2 }
}

public extension TimelineRow where Marker == StatusIndicator {
    /// Creates a timeline row using a status as its marker
    /// - Parameters:
    ///   - status: The row's work state (shown as a `StatusIndicator` marker)
    ///   - isFirst: First row (doesn't draw the top connector line)
    ///   - isLast: Last row (doesn't draw the bottom connector line)
    ///   - markerColumnWidth: Width of the marker column (default 32pt)
    ///   - content: The row's body
    init(
        status: StatusKind,
        isFirst: Bool = false,
        isLast: Bool = false,
        markerColumnWidth: CGFloat = 32,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            isFirst: isFirst,
            isLast: isLast,
            markerColumnWidth: markerColumnWidth,
            marker: { StatusIndicator(status) },
            content: content
        )
    }
}

// MARK: - Previews

#Preview("Status Timeline") {
    ScrollView {
        VStack(spacing: 0) {
            TimelineRow(status: .success, isFirst: true) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Searched the web").font(.subheadline)
                    Text("query: SwiftUI state management").font(.caption).foregroundStyle(.secondary)
                }
            }
            TimelineRow(status: .success) {
                Text("Fetched 3 pages").font(.subheadline)
            }
            TimelineRow(status: .running) {
                Text("Generating summary…").font(.subheadline)
            }
            TimelineRow(status: .pending, isLast: true) {
                Text("Compiling the answer").font(.subheadline)
            }
        }
        .padding()
    }
    .theme(ThemeProvider())
}

#Preview("Custom Marker Timeline") {
    VStack(spacing: 0) {
        TimelineRow(isFirst: true) {
            IconBadge(systemName: "magnifyingglass", size: .small)
        } content: {
            Text("Research agent").font(.subheadline)
        }
        TimelineRow(isLast: true) {
            IconBadge(systemName: "paintbrush", size: .small)
        } content: {
            Text("Visualizer").font(.subheadline)
        }
    }
    .padding()
    .theme(ThemeProvider())
}
