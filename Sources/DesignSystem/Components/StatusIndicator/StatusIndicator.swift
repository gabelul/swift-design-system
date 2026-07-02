import SwiftUI

/// A semantic status representing the state of asynchronous work.
///
/// Useful for representing the state of anything with a "pending → running → terminal"
/// lifecycle, such as agent execution, uploads, or sync.
public enum StatusKind: Sendable, Equatable, CaseIterable {
    /// Waiting to start
    case pending
    /// In progress
    case running
    /// Completed successfully
    case success
    /// Failed
    case failure
    /// Canceled
    case canceled
}

/// StatusIndicator Component
///
/// An indicator that represents a `StatusKind` as a single glyph combining an icon
/// with a semantic color. Shows the system `ProgressView` while running.
///
/// ## Basic Usage Examples
/// ```swift
/// StatusIndicator(.running)
/// StatusIndicator(.success)
///
/// // As a trailing element in a list row
/// HStack {
///     Text("Research Agent")
///     Spacer()
///     StatusIndicator(.running)
/// }
/// ```
public struct StatusIndicator: View {
    @Environment(\.colorPalette) private var colors

    private let kind: StatusKind

    /// Creates a status indicator
    /// - Parameter kind: The status to display
    public init(_ kind: StatusKind) {
        self.kind = kind
    }

    public var body: some View {
        Group {
            switch kind {
            case .pending:
                Image(systemName: "clock")
                    .foregroundStyle(colors.onSurfaceVariant)
            case .running:
                ProgressView()
                    .controlSize(.small)
            case .success:
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(colors.success)
            case .failure:
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(colors.error)
            case .canceled:
                Image(systemName: "slash.circle")
                    .foregroundStyle(colors.onSurfaceVariant)
            }
        }
        .accessibilityLabel(accessibilityText)
    }

    private var accessibilityText: String {
        switch kind {
        case .pending: "Pending"
        case .running: "In progress"
        case .success: "Completed"
        case .failure: "Failed"
        case .canceled: "Canceled"
        }
    }
}

// MARK: - StatusKind semantic color

public extension StatusKind {
    /// The semantic color that corresponds to the status.
    /// Exposed so surrounding elements (e.g. icon badge color) can match the indicator.
    func color(in palette: any ColorPalette) -> Color {
        switch self {
        case .pending, .canceled: palette.onSurfaceVariant
        case .running: palette.info
        case .success: palette.success
        case .failure: palette.error
        }
    }
}

// MARK: - Previews

#Preview("Status Indicators") {
    VStack(alignment: .leading, spacing: 16) {
        ForEach(StatusKind.allCases, id: \.self) { kind in
            HStack(spacing: 12) {
                StatusIndicator(kind)
                Text("\(kind)")
            }
        }
    }
    .padding()
    .theme(ThemeProvider())
}
