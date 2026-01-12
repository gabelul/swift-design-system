import SwiftUI

/// Chip Component
///
/// A compact label component that can be used for various purposes such as
/// status display, categories, filters, and user input.
///
/// ## Basic Usage Examples
/// ```swift
/// // Simple chip
/// Chip("Active")
///     .chipStyle(.filled)
///     .foregroundColor(.blue)
///
/// // Chip with icon
/// Chip("Completed", systemImage: "checkmark.circle.fill")
///     .chipStyle(.filled)
///     .foregroundColor(.green)
///
/// // Deletable chip
/// Chip("Swift", systemImage: "tag.fill") {
///     removeTag("Swift")
/// }
/// .chipStyle(.filled)
///
/// // Selectable filter chip
/// Chip("Filter", systemImage: "line.3.horizontal.decrease", isSelected: $isFiltered)
///     .chipStyle(.outlined)
/// ```
///
/// ## Style Variants
/// - **Filled**: Filled background (default)
/// - **Outlined**: Border only
/// - **Liquid Glass**: Semi-transparent glass effect
///
/// ## Size Variants
/// - **Small**: 24pt height, for dense layouts
/// - **Medium**: 32pt height, for standard use (default)
public struct Chip: View {
    @Environment(\.chipStyle) private var chipStyle
    @Environment(\.chipSize) private var size
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacingScale
    @Environment(\.radiusScale) private var radiusScale
    @Environment(\.motion) private var motion

    private let label: String
    private let systemImage: String?
    private let onDelete: (() -> Void)?
    private let onAction: (() -> Void)?
    private let isSelectable: Bool
    @Binding private var isSelected: Bool
    @State private var isPressed: Bool = false

    // MARK: - Initializers

    /// Creates a text-only Chip
    /// - Parameter label: The text to display
    public init(_ label: String) {
        self.label = label
        self.systemImage = nil
        self.onDelete = nil
        self.onAction = nil
        self.isSelectable = false
        self._isSelected = .constant(false)
    }

    /// Creates a Chip with an icon
    /// - Parameters:
    ///   - label: The text to display
    ///   - systemImage: SF Symbols icon name
    public init(_ label: String, systemImage: String) {
        self.label = label
        self.systemImage = systemImage
        self.onDelete = nil
        self.onAction = nil
        self.isSelectable = false
        self._isSelected = .constant(false)
    }

    /// Creates an action Chip (Action Chip)
    ///
    /// A Chip that executes a specified action when tapped.
    /// The delete button is not shown, and the entire Chip becomes the tap area.
    ///
    /// - Parameters:
    ///   - label: The text to display
    ///   - systemImage: SF Symbols icon name (optional)
    ///   - action: The action to execute when tapped
    public init(
        _ label: String,
        systemImage: String? = nil,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.systemImage = systemImage
        self.onDelete = nil
        self.onAction = action
        self.isSelectable = false
        self._isSelected = .constant(false)
    }

    /// Creates a deletable Chip (Input Chip)
    /// - Parameters:
    ///   - label: The text to display
    ///   - systemImage: SF Symbols icon name (optional)
    ///   - onDelete: Handler when delete button is tapped
    public init(
        _ label: String,
        systemImage: String? = nil,
        onDelete: @escaping () -> Void
    ) {
        self.label = label
        self.systemImage = systemImage
        self.onDelete = onDelete
        self.onAction = nil
        self.isSelectable = false
        self._isSelected = .constant(false)
    }

    /// Creates a selectable Chip (Filter Chip)
    /// - Parameters:
    ///   - label: The text to display
    ///   - systemImage: SF Symbols icon name (optional)
    ///   - isSelected: Binding for selection state
    public init(
        _ label: String,
        systemImage: String? = nil,
        isSelected: Binding<Bool>
    ) {
        self.label = label
        self.systemImage = systemImage
        self.onDelete = nil
        self.onAction = nil
        self.isSelectable = true
        self._isSelected = isSelected
    }

    // MARK: - Body

    public var body: some View {
        let configuration = ChipStyleConfiguration(
            label: AnyView(Text(label)),
            icon: systemImage.map { AnyView(Image(systemName: $0)) },
            onDelete: onDelete,
            isSelected: isSelected,
            isPressed: isPressed,
            size: size,
            colorPalette: colorPalette,
            spacingScale: spacingScale,
            radiusScale: radiusScale,
            motion: motion
        )

        Group {
            if onDelete != nil || onAction != nil || isSelectable {
                // Tappable chip (delete, action, or selection)
                Button(action: handleTap) {
                    chipStyle.makeBody(configuration: configuration)
                }
                .buttonStyle(ChipButtonStyle(isPressed: $isPressed))
            } else {
                // Static chip
                chipStyle.makeBody(configuration: configuration)
            }
        }
    }

    // MARK: - Private Methods

    private func handleTap() {
        if let onDelete = onDelete {
            // Delete action
            onDelete()
        } else if let onAction = onAction {
            // Execute action
            onAction()
        } else {
            // Toggle selection
            withAnimation(motion.toggle) {
                isSelected.toggle()
            }
        }
    }
}

// MARK: - ChipButtonStyle

/// Chip button style (for tap feedback)
private struct ChipButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, newValue in
                isPressed = newValue
            }
    }
}

// MARK: - Previews

#Preview("Basic Chips") {
    VStack(spacing: 16) {
        Chip("Active")
            .chipStyle(.filled)
            .foregroundColor(.blue)

        Chip("Completed", systemImage: "checkmark.circle.fill")
            .chipStyle(.filled)
            .foregroundColor(.green)

        Chip("New", systemImage: "bell.fill")
            .chipStyle(.filled)
            .chipSize(.small)
            .foregroundColor(.orange)
    }
    .padding()
}

#Preview("Deletable Chips") {
    VStack(spacing: 16) {
        Chip("Swift", systemImage: "tag.fill", onDelete: {
            print("Delete Swift")
        })
        .chipStyle(.filled)
        .foregroundColor(.blue)

        Chip("SwiftUI", onDelete: {
            print("Delete SwiftUI")
        })
        .chipStyle(.filled)
        .chipSize(.small)
        .foregroundColor(.purple)
    }
    .padding()
}

#Preview("Action Chips") {
    VStack(spacing: 16) {
        Chip("Play", systemImage: "play.fill", action: {
            print("Play tapped")
        })
        .chipStyle(.outlined)

        Chip("Share", systemImage: "square.and.arrow.up", action: {
            print("Share tapped")
        })
        .chipStyle(.outlined)

        Chip("Save", systemImage: "square.and.arrow.down", action: {
            print("Save tapped")
        })
        .chipStyle(.filled)
    }
    .padding()
}

#Preview("Selectable Chips") {
    struct SelectableChipExample: View {
        @State private var isSelected1 = false
        @State private var isSelected2 = true

        var body: some View {
            VStack(spacing: 16) {
                Chip("Filter", systemImage: "line.3.horizontal.decrease", isSelected: $isSelected1)
                    .chipStyle(.outlined)

                Chip("Favorite", systemImage: "star.fill", isSelected: $isSelected2)
                    .chipStyle(.outlined)
            }
            .padding()
        }
    }

    return SelectableChipExample()
}
