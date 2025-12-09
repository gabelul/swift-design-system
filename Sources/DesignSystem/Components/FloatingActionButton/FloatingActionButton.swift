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

    private let icon: String
    private let size: FABSize
    private let action: () -> Void

    public init(
        icon: String,
        size: FABSize = .regular,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: size.iconSize, weight: .semibold))
                .foregroundStyle(colorPalette.onPrimaryContainer)
                .frame(width: size.diameter, height: size.diameter)
                .background(colorPalette.primaryContainer)
                .clipShape(Circle())
        }
        .elevation(.level3)
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
