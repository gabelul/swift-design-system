import SwiftUI

/// Styled search input with clear and cancel buttons
///
/// A themed search bar with magnifying glass icon, inline clear button,
/// and optional cancel button. Styled to match the design system tokens.
///
/// ## Usage
/// ```swift
/// @State private var query = ""
///
/// SearchField(text: $query, placeholder: "Search items...")
///
/// // With submit handler
/// SearchField(text: $query, onSubmit: { performSearch() })
///
/// // Without cancel button
/// SearchField(text: $query, showsCancelButton: false)
/// ```
public struct SearchField: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @FocusState private var isFocused: Bool

    @Binding private var text: String
    private let placeholder: String
    private let showsCancelButton: Bool
    private let onSubmit: (() -> Void)?

    /// Creates a search field
    ///
    /// - Parameters:
    ///   - text: Binding to the search text
    ///   - placeholder: Placeholder text (default: "Search")
    ///   - showsCancelButton: Show a cancel button when focused (default: true)
    ///   - onSubmit: Called when the user submits the search (optional)
    public init(
        text: Binding<String>,
        placeholder: String = "Search",
        showsCancelButton: Bool = true,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.showsCancelButton = showsCancelButton
        self.onSubmit = onSubmit
    }

    public var body: some View {
        HStack(spacing: spacing.sm) {
            // Search bar
            HStack(spacing: spacing.sm) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(colors.onSurfaceVariant)

                TextField(placeholder, text: $text)
                    .typography(.bodyMedium)
                    .foregroundStyle(colors.onSurface)
                    .focused($isFocused)
                    .onSubmit { onSubmit?() }

                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(colors.onSurfaceVariant)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, spacing.md)
            .padding(.vertical, spacing.sm)
            .background(colors.surfaceVariant)
            .clipShape(RoundedRectangle(cornerRadius: radius.lg))

            // Cancel button
            if showsCancelButton && isFocused {
                Button("Cancel") {
                    text = ""
                    isFocused = false
                }
                .typography(.bodyMedium)
                .foregroundStyle(colors.primary)
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}

#Preview {
    VStack(spacing: 16) {
        SearchField(text: .constant(""))
        SearchField(text: .constant("SwiftUI"))
    }
    .padding()
    .theme(ThemeProvider())
}
