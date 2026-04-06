import SwiftUI

/// Password input field matching DSTextField styling
///
/// Mirrors `DSTextField`'s visual design with a toggle to reveal/hide the password.
/// Supports the same outlined/filled styles and error states.
///
/// ## Usage
/// ```swift
/// @State private var password = ""
/// @State private var error: String?
///
/// DSSecureField(
///     "Password",
///     text: $password,
///     placeholder: "Enter password",
///     leadingIcon: "lock"
/// )
///
/// // With error
/// DSSecureField(
///     "Password",
///     text: $password,
///     error: "Must be at least 8 characters"
/// )
/// ```
public struct DSSecureField: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @FocusState private var isFocused: Bool
    @State private var isRevealed: Bool = false

    private let title: String
    @Binding private var text: String
    private let placeholder: String
    private let style: TextFieldStyle
    private let supportingText: String?
    private let error: String?
    private let leadingIcon: String?

    /// Creates a secure text field
    ///
    /// - Parameters:
    ///   - title: Label text above the field
    ///   - text: Binding to the password text
    ///   - placeholder: Placeholder text
    ///   - style: Visual style — .outlined (default) or .filled
    ///   - supportingText: Helper text below the field
    ///   - error: Error message (overrides supportingText, turns border red)
    ///   - leadingIcon: SF Symbol name for the leading icon
    public init(
        _ title: String = "",
        text: Binding<String>,
        placeholder: String = "",
        style: TextFieldStyle = .outlined,
        supportingText: String? = nil,
        error: String? = nil,
        leadingIcon: String? = nil
    ) {
        self.title = title
        self._text = text
        self.placeholder = placeholder
        self.style = style
        self.supportingText = supportingText
        self.error = error
        self.leadingIcon = leadingIcon
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing.xs) {
            // Label
            if !title.isEmpty {
                Text(title)
                    .typography(.bodySmall)
                    .foregroundStyle(labelColor)
            }

            // Input field
            HStack(spacing: spacing.md) {
                if let leadingIcon {
                    Image(systemName: leadingIcon)
                        .font(.system(size: 20))
                        .foregroundStyle(iconColor)
                }

                Group {
                    if isRevealed {
                        TextField(placeholder, text: $text)
                    } else {
                        SwiftUI.SecureField(placeholder, text: $text)
                    }
                }
                .typography(.bodyLarge)
                .foregroundStyle(colors.onSurface)
                .focused($isFocused)

                // Reveal/hide toggle
                Button {
                    isRevealed.toggle()
                } label: {
                    Image(systemName: isRevealed ? "eye.slash.fill" : "eye.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(iconColor)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, spacing.lg)
            .padding(.vertical, spacing.md)
            .background(backgroundColor)
            .overlay(border)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))

            // Supporting/error text
            if let error {
                Text(error)
                    .typography(.bodySmall)
                    .foregroundStyle(colors.error)
            } else if let supportingText {
                Text(supportingText)
                    .typography(.bodySmall)
                    .foregroundStyle(colors.onSurfaceVariant)
            }
        }
    }

    // MARK: - Computed Styles (mirrors DSTextField)

    private var labelColor: Color {
        if error != nil { return colors.error }
        return isFocused ? colors.primary : colors.onSurfaceVariant
    }

    private var iconColor: Color {
        if error != nil { return colors.error }
        return isFocused ? colors.primary : colors.onSurfaceVariant
    }

    private var backgroundColor: Color {
        switch style {
        case .filled: return colors.surfaceVariant
        case .outlined: return .clear
        }
    }

    @ViewBuilder
    private var border: some View {
        switch style {
        case .filled:
            EmptyView()
        case .outlined:
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: isFocused ? 2 : 1)
        }
    }

    private var borderColor: Color {
        if error != nil { return colors.error }
        return isFocused ? colors.primary : colors.outline
    }

    private var cornerRadius: CGFloat { 4 }
}

#Preview {
    VStack(spacing: 16) {
        DSSecureField(
            "Password",
            text: .constant(""),
            placeholder: "Enter password",
            leadingIcon: "lock"
        )

        DSSecureField(
            "Confirm Password",
            text: .constant("abc"),
            placeholder: "Re-enter password",
            style: .filled,
            error: "Passwords don't match"
        )
    }
    .padding()
    .theme(ThemeProvider())
}
