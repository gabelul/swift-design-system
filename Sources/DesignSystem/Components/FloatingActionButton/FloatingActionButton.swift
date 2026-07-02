import SwiftUI

/// Floating Action Button (FAB)
///
/// Circular floating button that represents the primary action on a screen.
/// Typically placed at the bottom‑right corner and used for important actions
/// such as create/add.
///
/// ## Example
/// ```swift
/// // Regular size
/// FloatingActionButton(icon: "plus") {
///     createNewItem()
/// }
///
/// // Size variations
/// FloatingActionButton(icon: "pencil", size: .small) {
///     edit()
/// }
///
/// FloatingActionButton(icon: "photo", size: .large) {
///     addPhoto()
/// }
/// ```
///
/// ## Layout example
/// ```swift
/// ZStack {
///     ContentView()
///
///     VStack {
///         Spacer()
///         HStack {
///             Spacer()
///             FloatingActionButton(icon: "plus") {
///                 createNew()
///             }
///             .padding()
///         }
///     }
/// }
/// ```
///
/// ## Sizes
/// - **Small**: 40pt diameter – compact layouts
/// - **Regular**: 56pt diameter – standard size (recommended)
/// - **Large**: 96pt diameter – especially important actions
public struct FloatingActionButton: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.isEnabled) private var isEnabled

    private let icon: String
    private let size: FABSize
    private let style: FABStyle
    private let action: () -> Void

    public init(
        icon: String,
        size: FABSize = .regular,
        style: FABStyle = .primary,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.style = style
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            content
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1 : 0.6)
    }

    private var content: some View {
        Image(systemName: icon)
            .font(.system(size: size.iconSize, weight: .semibold))
            .foregroundStyle(foregroundColor)
            .frame(width: size.diameter, height: size.diameter)
            .background(background)
            .clipShape(Circle())
            .elevation(style.elevation)
    }

    @ViewBuilder
    private var background: some View {
        switch style {
        case .primary:
            Circle()
                .fill(colorPalette.primaryContainer)
        case .secondary:
            Circle()
                .fill(colorPalette.secondaryContainer)
        case .glass:
            if #available(iOS 26.0, macOS 26.0, *) {
                Circle()
                    .fill(colorPalette.primary.opacity(0.05))
                    .glassEffect(.regular.tint(colorPalette.primary.opacity(0.18)).interactive(true), in: Circle())
            } else {
                Circle()
                    .fill(colorPalette.primary.opacity(0.06))
                    .background(.ultraThinMaterial, in: Circle())
            }
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary:
            colorPalette.onPrimaryContainer
        case .secondary:
            colorPalette.onSecondaryContainer
        case .glass:
            colorPalette.primary
        }
    }

}

/// FAB visual style.
public enum FABStyle: Sendable {
    /// Standard primary action using the theme's primary container.
    case primary

    /// Supporting floating action using the secondary container.
    case secondary

    /// Floating action using a Liquid Glass appearance.
    case glass

    var elevation: Elevation {
        switch self {
        case .primary, .secondary:
            .level3
        case .glass:
            .level4
        }
    }
}

/// FAB size variants.
public enum FABSize {
    case small
    case regular
    case large

    var diameter: CGFloat {
        switch self {
        case .small: return 40
        case .regular: return 56
        case .large: return 96
        }
    }

    var iconSize: CGFloat {
        switch self {
        case .small: return 18
        case .regular: return 24
        case .large: return 36
        }
    }
}

struct FABPreview: View {
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        VStack(spacing: spacing.xxl) {
            FloatingActionButton(icon: "plus", size: .small) {
                print("Small FAB tapped")
            }

            FloatingActionButton(icon: "plus", size: .regular) {
                print("Regular FAB tapped")
            }

            FloatingActionButton(icon: "plus", size: .large) {
                print("Large FAB tapped")
            }
        }
    }
}

#Preview {
    FABPreview()
        .theme(ThemeProvider())
}
