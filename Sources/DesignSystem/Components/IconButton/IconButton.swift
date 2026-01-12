import SwiftUI

/// Icon button
///
/// Circular button component using SF Symbols icons.
/// Compact and ideal for toolbars and navigation bars.
///
/// ## Usage Examples
/// ```swift
/// // Standard style
/// IconButton(icon: "heart") {
///     toggleFavorite()
/// }
///
/// // Filled style
/// IconButton(icon: "star.fill", style: .filled) {
///     addToFavorites()
/// }
///
/// // Size specification
/// HStack {
///     IconButton(icon: "gear", size: .small) { }
///     IconButton(icon: "gear", size: .medium) { }
///     IconButton(icon: "gear", size: .large) { }
/// }
/// ```
///
/// ## Style Variations
/// - **Standard**: No background, icon only
/// - **Filled**: Primary color background
/// - **Tonal**: SecondaryContainer color background
/// - **Outlined**: Outline only (no background)
public struct IconButton: View {
    @Environment(\.colorPalette) private var colorPalette

    private let icon: String
    private let style: IconButtonStyle
    private let size: IconButtonSize
    private let action: () -> Void

    public init(
        icon: String,
        style: IconButtonStyle = .standard,
        size: IconButtonSize = .medium,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.style = style
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size.iconSize, weight: .regular))
                .foregroundStyle(foregroundColor)
                .frame(width: size.containerSize, height: size.containerSize)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .standard:
            return colorPalette.onSurfaceVariant
        case .filled:
            return colorPalette.onPrimary
        case .tonal:
            return colorPalette.onSecondaryContainer
        case .outlined:
            return colorPalette.onSurfaceVariant
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .standard:
            return .clear
        case .filled:
            return colorPalette.primary
        case .tonal:
            return colorPalette.secondaryContainer
        case .outlined:
            return .clear
        }
    }
}

/// IconButton style
public enum IconButtonStyle {
    /// Standard (no background)
    case standard
    /// Filled (primary color background)
    case filled
    /// Tonal (secondary container background)
    case tonal
    /// Outlined (border only)
    case outlined
}

/// IconButton size
public enum IconButtonSize {
    case small
    case medium
    case large

    var containerSize: CGFloat {
        switch self {
        case .small: return 32
        case .medium: return 40
        case .large: return 48
        }
    }

    var iconSize: CGFloat {
        switch self {
        case .small: return 16
        case .medium: return 20
        case .large: return 24
        }
    }
}

struct IconButtonPreview: View {
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        VStack(spacing: spacing.xl) {
            HStack(spacing: spacing.lg) {
                IconButton(icon: "heart", style: .standard) {}
                IconButton(icon: "heart", style: .filled) {}
                IconButton(icon: "heart", style: .tonal) {}
                IconButton(icon: "heart", style: .outlined) {}
            }

            HStack(spacing: spacing.lg) {
                IconButton(icon: "star", size: .small) {}
                IconButton(icon: "star", size: .medium) {}
                IconButton(icon: "star", size: .large) {}
            }
        }
    }
}

#Preview {
    IconButtonPreview()
        .theme(ThemeProvider())
}
