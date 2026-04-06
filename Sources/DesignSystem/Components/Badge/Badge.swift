import SwiftUI

/// Notification dot or count badge
///
/// Displays a small indicator — either a dot or a number — typically
/// overlaid on icons, avatars, or tab items to signal unread counts or status.
///
/// ## Usage
/// ```swift
/// // Dot badge (no count)
/// Badge()
///
/// // Count badge
/// Badge(count: 5)
///
/// // As a ViewModifier on any view
/// Image(systemName: "bell.fill")
///     .badge(3)
///
/// // Dot-only modifier
/// Image(systemName: "envelope.fill")
///     .badge()
/// ```
public struct Badge: View {
    @Environment(\.colorPalette) private var colors

    private let count: Int?
    private let maxCount: Int
    private let backgroundColor: Color?
    private let foregroundColor: Color?

    /// Creates a badge with an optional count
    ///
    /// - Parameters:
    ///   - count: Number to display. `nil` shows a dot instead (default: nil)
    ///   - maxCount: Maximum displayable number before showing "N+" (default: 99)
    ///   - backgroundColor: Override badge color (default: error red)
    ///   - foregroundColor: Override text color (default: onError white)
    public init(
        count: Int? = nil,
        maxCount: Int = 99,
        backgroundColor: Color? = nil,
        foregroundColor: Color? = nil
    ) {
        self.count = count
        self.maxCount = maxCount
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    public var body: some View {
        if let count {
            Text(count > maxCount ? "\(maxCount)+" : "\(count)")
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(foregroundColor ?? colors.onError)
                .padding(.horizontal, 5)
                .frame(minWidth: 18, minHeight: 18)
                .background(backgroundColor ?? colors.error)
                .clipShape(Capsule())
        } else {
            Circle()
                .fill(backgroundColor ?? colors.error)
                .frame(width: 10, height: 10)
        }
    }
}

// MARK: - ViewModifier

/// Attaches a badge to the top-trailing corner of any view
struct BadgeModifier: ViewModifier {
    let count: Int?
    let isVisible: Bool

    func body(content: Content) -> some View {
        content.overlay(alignment: .topTrailing) {
            if isVisible {
                Badge(count: count)
                    .offset(x: 6, y: -6)
            }
        }
    }
}

public extension View {
    /// Attaches a count badge to this view
    ///
    /// - Parameters:
    ///   - count: Number to display (omit for a dot badge)
    ///   - isVisible: Controls badge visibility (default: true)
    func badge(_ count: Int? = nil, isVisible: Bool = true) -> some View {
        modifier(BadgeModifier(count: count, isVisible: isVisible))
    }
}

#Preview {
    HStack(spacing: 32) {
        // Dot badge
        Image(systemName: "bell.fill")
            .font(.title2)
            .badge()

        // Count badge
        Image(systemName: "envelope.fill")
            .font(.title2)
            .badge(5)

        // Overflow
        Image(systemName: "message.fill")
            .font(.title2)
            .badge(150)
    }
    .padding()
    .theme(ThemeProvider())
}
