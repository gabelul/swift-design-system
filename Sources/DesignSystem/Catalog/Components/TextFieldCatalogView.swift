import SwiftUI

/// TextField component catalog view
struct TextFieldCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var search = ""
    @State private var message = ""

    var body: some View {
        CatalogPageContainer(title: "TextField") {
            CatalogOverview(description: "Component for receiving text input from users")

            SectionCard(title: "Styles") {
                VariantShowcase(title: "Style Variations", description: "2 styles available") {
                    VStack(spacing: spacing.lg) {
                        DSTextField("Outlined", text: $email, placeholder: "Email address", style: .outlined)
                        DSTextField("Filled", text: $password, placeholder: "Password", style: .filled)
                    }
                }
            }

            SectionCard(title: "Icons") {
                VariantShowcase(title: "With Icons", description: "Place icons at the beginning or end") {
                    VStack(spacing: spacing.lg) {
                        DSTextField("Leading", text: $email, placeholder: "example@email.com", style: .outlined, leadingIcon: "envelope")
                        DSTextField("Trailing", text: $search, placeholder: "Search", style: .outlined, trailingIcon: "magnifyingglass")
                        DSTextField("Both", text: $password, placeholder: "Password", style: .outlined, leadingIcon: "lock", trailingIcon: "eye")
                    }
                }
            }

            SectionCard(title: "Supporting Text") {
                DSTextField("Username", text: $username, placeholder: "Enter username", style: .outlined, supportingText: "3-20 characters")
            }

            SectionCard(title: "Error State") {
                DSTextField("Email", text: $email, placeholder: "example@email.com", style: .outlined, error: "Invalid format", leadingIcon: "envelope")
            }

            SectionCard(title: "Multiline") {
                VStack(alignment: .leading, spacing: spacing.xs) {
                    Text("Message")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurface.opacity(0.7))

                    TextEditor(text: $message)
                        .typography(.bodyLarge)
                        .scrollContentBackground(.hidden)
                        .frame(height: 100)
                        .padding(.horizontal, spacing.md)
                        .padding(.vertical, spacing.sm)
                        .background(colors.surfaceVariant.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(colors.outline, lineWidth: 1))
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    DSTextField(
                        "Email Address",
                        text: $email,
                        placeholder: "example@email.com",
                        style: .outlined,
                        leadingIcon: "envelope"
                    )
                    """)
            }

            SectionCard(title: "Form Example") {
                Card {
                    VStack(spacing: spacing.lg) {
                        Text("Account Registration")
                            .typography(.titleLarge)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        DSTextField("Email Address", text: $email, placeholder: "example@email.com", style: .outlined, leadingIcon: "envelope")
                        DSTextField("Password", text: $password, placeholder: "Password", style: .outlined, supportingText: "8+ characters", leadingIcon: "lock")
                        DSTextField("Username", text: $username, placeholder: "Username", style: .outlined, leadingIcon: "person")

                        Button("Register") {}
                            .buttonStyle(.primary)
                            .buttonSize(.large)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TextFieldCatalogView()
            .theme(ThemeProvider())
    }
}
