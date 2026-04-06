import SwiftUI

struct SecureFieldCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Password input field matching DSTextField styling. Includes a toggle to reveal/hide the password.")

                SectionCard(title: "Outlined (Default)") {
                    DSSecureField(
                        "Password",
                        text: .constant(""),
                        placeholder: "Enter password",
                        leadingIcon: "lock"
                    )
                }

                SectionCard(title: "Filled Style") {
                    DSSecureField(
                        "Password",
                        text: .constant("secret123"),
                        placeholder: "Enter password",
                        style: .filled,
                        supportingText: "At least 8 characters"
                    )
                }

                SectionCard(title: "With Error") {
                    DSSecureField(
                        "Confirm Password",
                        text: .constant("abc"),
                        placeholder: "Re-enter password",
                        error: "Passwords don't match"
                    )
                }

                CodeExample(code: """
                DSSecureField(
                    "Password",
                    text: $password,
                    placeholder: "Enter password",
                    leadingIcon: "lock"
                )
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .navigationTitle("SecureField")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { SecureFieldCatalogView().theme(ThemeProvider()) } }
