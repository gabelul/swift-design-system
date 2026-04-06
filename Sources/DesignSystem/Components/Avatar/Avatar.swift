import SwiftUI

/// Avatar size presets
public enum AvatarSize: Sendable {
    case small, medium, large, extraLarge

    /// Diameter in points
    var dimension: CGFloat {
        switch self {
        case .small: return 32
        case .medium: return 48
        case .large: return 64
        case .extraLarge: return 80
        }
    }

    /// Font size for initials text
    var fontSize: CGFloat {
        switch self {
        case .small: return 12
        case .medium: return 18
        case .large: return 24
        case .extraLarge: return 32
        }
    }
}

/// Circular avatar with image or initials fallback
///
/// Displays a user photo in a circle, falling back to colored initials
/// when no image is available. Supports an optional status badge overlay.
///
/// ## Usage
/// ```swift
/// // With an image
/// Avatar(image: Image("profile"), size: .large)
///
/// // With initials fallback
/// Avatar(initials: "JD", size: .medium)
///
/// // With status badge
/// Avatar(initials: "AB", size: .large)
///     .badge()
/// ```
public struct Avatar: View {
    @Environment(\.colorPalette) private var colors

    private let image: Image?
    private let initials: String?
    private let size: AvatarSize

    /// Creates an avatar with an image
    ///
    /// - Parameters:
    ///   - image: The profile image to display
    ///   - size: Avatar size preset (default: .medium)
    public init(image: Image, size: AvatarSize = .medium) {
        self.image = image
        self.initials = nil
        self.size = size
    }

    /// Creates an avatar with initials (text fallback)
    ///
    /// - Parameters:
    ///   - initials: 1–2 characters to display (e.g. "JD")
    ///   - size: Avatar size preset (default: .medium)
    public init(initials: String, size: AvatarSize = .medium) {
        self.image = nil
        self.initials = String(initials.prefix(2)).uppercased()
        self.size = size
    }

    public var body: some View {
        Group {
            if let image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                Text(initials ?? "?")
                    .font(.system(size: size.fontSize, weight: .semibold, design: .rounded))
                    .foregroundStyle(colors.onPrimary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(colors.primary.opacity(0.8))
            }
        }
        .frame(width: size.dimension, height: size.dimension)
        .clipShape(Circle())
    }
}

#Preview {
    HStack(spacing: 16) {
        Avatar(initials: "AB", size: .small)
        Avatar(initials: "CD", size: .medium)
        Avatar(initials: "EF", size: .large)
        Avatar(initials: "G", size: .extraLarge)
    }
    .padding()
    .theme(ThemeProvider())
}
