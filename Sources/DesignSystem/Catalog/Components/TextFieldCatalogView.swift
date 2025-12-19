import SwiftUI

/// TextField component catalog view
struct TextFieldCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var search = ""
    @State private var message = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Overview
                Text("Text fields are components for capturing user text input.")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.horizontal, spacing.lg)
                    .padding(.top, spacing.lg)

                // Style variations
                SectionCard(title: "Style Variations") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Two styles are available.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.lg) {
                            DSTextField(
                                "Outlined",
                                text: $email,
                                placeholder: "Email address",
                                style: .outlined
                            )

                            DSTextField(
                                "Filled",
                                text: $password,
                                placeholder: "Password",
                                style: .filled
                            )
                        }
                    }
                }

                // With icons
                SectionCard(title: "With Icons") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Place icons at the leading or trailing edge.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.lg) {
                            DSTextField(
                                "Leading Icon",
                                text: $email,
                                placeholder: "example@email.com",
                                style: .outlined,
                                leadingIcon: "envelope"
                            )

                            DSTextField(
                                "Trailing Icon",
                                text: $search,
                                placeholder: "Search",
                                style: .outlined,
                                trailingIcon: "magnifyingglass"
                            )

                            DSTextField(
                                "Both Icons",
                                text: $password,
                                placeholder: "Password",
                                style: .outlined,
                                leadingIcon: "lock",
                                trailingIcon: "eye"
                            )
                        }
                    }
                }

                // Supporting text
                SectionCard(title: "Supporting Text") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Show additional helper information below the field.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        DSTextField(
                            "Username",
                            text: $username,
                            placeholder: "Enter username",
                            style: .outlined,
                            supportingText: "Please enter 3–20 characters."
                        )
                    }
                }

                // Error state
                SectionCard(title: "Error State") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Display validation errors.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        DSTextField(
                            "Email",
                            text: $email,
                            placeholder: "example@email.com",
                            style: .outlined,
                            error: "The email address format is invalid.",
                            leadingIcon: "envelope"
                        )
                    }
                }

                // Multiline text
                SectionCard(title: "Multiline Text") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("For longer text input.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Message")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurface.opacity(0.7))

                            TextEditor(text: $message)
                                .typography(.bodyLarge)
                                .scrollContentBackground(.hidden)
                                .frame(height: 100)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(colorPalette.surfaceVariant.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(colorPalette.outline, lineWidth: 1)
                                )

                            Text("Please enter a message.")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)
                        }
                    }
                }

                // Usage
                SectionCard(title: "Usage") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to use in SwiftUI")
                            .typography(.titleSmall)

                        Text("""
                        @State private var email = ""

                        DSTextField(
                            "Email",
                            text: $email,
                            placeholder: "example@email.com",
                            style: .outlined,
                            leadingIcon: "envelope"
                        )
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant.opacity(0.5))
                        .cornerRadius(8)
                    }
                }

                // Form example
                SectionCard(title: "Form Example") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Example usage in a real form.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        Card {
                            VStack(spacing: spacing.lg) {
                                Text("Account Registration")
                                    .typography(.titleLarge)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                DSTextField(
                                    "Email",
                                    text: $email,
                                    placeholder: "example@email.com",
                                    style: .outlined,
                                    leadingIcon: "envelope"
                                )

                                DSTextField(
                                    "Password",
                                    text: $password,
                                    placeholder: "Password",
                                    style: .outlined,
                                    supportingText: "Enter at least 8 characters.",
                                    leadingIcon: "lock"
                                )

                                DSTextField(
                                    "Username",
                                    text: $username,
                                    placeholder: "Username",
                                    style: .outlined,
                                    leadingIcon: "person"
                                )

                                Button("登録") {}
                                    .buttonStyle(.primary)
                                    .buttonSize(.large)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("TextField")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        TextFieldCatalogView()
            .theme(ThemeProvider())
    }
}
