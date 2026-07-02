import SwiftUI

/// LinkCard Component
///
/// A component that represents a reference to a URL (source, related link, citation, etc.)
/// as a single card. Displays a title, domain, and optional accessory (status chip, etc.),
/// and runs an arbitrary action on tap (e.g. opening an in-app browser).
///
/// Fetching metadata (via LinkPresentation, etc.) is the caller's responsibility —
/// this component only displays the data it's given.
///
/// ## Basic Usage Examples
/// ```swift
/// // Simple link card
/// LinkCard(title: "Swift.org - Concurrency", url: url) {
///     openInBrowser(url)
/// }
///
/// // With a status (e.g. source verification result)
/// LinkCard(title: "WWDC25 Session Notes", url: url) {
///     openInBrowser(url)
/// } accessory: {
///     Chip("Fetched", systemImage: "checkmark")
///         .chipStyle(.filled)
///         .chipSize(.small)
/// }
/// ```
public struct LinkCard<Accessory: View>: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    private let title: String?
    private let url: URL
    private let systemImage: String
    private let action: (() -> Void)?
    private let accessory: Accessory

    /// Creates a link card
    /// - Parameters:
    ///   - title: Display title. Uses the host name if nil
    ///   - url: Target URL (host name is shown as the subtitle)
    ///   - systemImage: Leading icon (default "globe")
    ///   - action: Action to run on tap. Static display if nil
    ///   - accessory: Trailing accessory view (status chip, etc.)
    public init(
        title: String?,
        url: URL,
        systemImage: String = "globe",
        action: (() -> Void)? = nil,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.title = title
        self.url = url
        self.systemImage = systemImage
        self.action = action
        self.accessory = accessory()
    }

    public var body: some View {
        if let action {
            Button(action: action) { cardBody }
                .buttonStyle(.plain)
                .accessibilityLabel(displayTitle)
                .accessibilityHint("Opens the link")
        } else {
            cardBody
        }
    }

    private var cardBody: some View {
        HStack(spacing: spacing.sm) {
            IconBadge(
                systemName: systemImage,
                size: .small,
                foregroundColor: colors.primary,
                backgroundColor: colors.primary.opacity(0.12)
            )
            VStack(alignment: .leading, spacing: spacing.xxs) {
                Text(displayTitle)
                    .typography(.labelLarge)
                    .foregroundStyle(colors.onSurface)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                if let host = url.host() {
                    Text(host)
                        .typography(.labelSmall)
                        .foregroundStyle(colors.onSurfaceVariant)
                        .lineLimit(1)
                }
            }
            Spacer(minLength: spacing.xs)
            accessory
            if action != nil {
                Image(systemName: "arrow.up.right")
                    .typography(.labelMedium)
                    .foregroundStyle(colors.onSurfaceVariant)
            }
        }
        .padding(spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(colors.elevatedSurface, in: RoundedRectangle(cornerRadius: radius.lg, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: radius.lg, style: .continuous))
    }

    private var displayTitle: String {
        if let title, !title.isEmpty { return title }
        return url.host() ?? url.absoluteString
    }
}

public extension LinkCard where Accessory == EmptyView {
    /// Creates a link card with no accessory
    /// - Parameters:
    ///   - title: Display title. Uses the host name if nil
    ///   - url: Target URL
    ///   - systemImage: Leading icon (default "globe")
    ///   - action: Action to run on tap. Static display if nil
    init(
        title: String?,
        url: URL,
        systemImage: String = "globe",
        action: (() -> Void)? = nil
    ) {
        self.init(title: title, url: url, systemImage: systemImage, action: action) {
            EmptyView()
        }
    }
}

// MARK: - Previews

#Preview("Link Cards") {
    VStack(spacing: 12) {
        LinkCard(
            title: "Swift Concurrency - The Swift Programming Language",
            url: URL(string: "https://docs.swift.org/swift-book/")!
        ) {}

        LinkCard(
            title: nil,
            url: URL(string: "https://developer.apple.com/videos/")!
        ) {}

        LinkCard(
            title: "Verified Source",
            url: URL(string: "https://swift.org/blog/")!,
            action: {}
        ) {
            Chip("Fetched", systemImage: "checkmark")
                .chipStyle(.filled)
                .chipSize(.small)
                .foregroundColor(.green)
        }
    }
    .padding()
    .theme(ThemeProvider())
}
