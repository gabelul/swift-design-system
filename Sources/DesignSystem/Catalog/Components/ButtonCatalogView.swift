import SwiftUI

/// Catalog view for button component
struct ButtonCatalogView: View {
    @Environment(\.spacingScale) private var spacing
    @State private var isButtonEnabled = true

    var body: some View {
        CatalogPageContainer(title: "Button") {
            CatalogOverview(description: "View button variations and sizes")

            Toggle("Enable buttons", isOn: $isButtonEnabled)
                .padding(.horizontal, spacing.lg)

            SectionCard(title: "Primary") {
                VariantShowcase(
                    title: "Primary Button",
                    description: "Used for primary actions"
                ) {
                    VStack(spacing: spacing.md) {
                        Button("Large") { }
                            .buttonStyle(.primary)
                            .buttonSize(.large)

                        Button("Medium") { }
                            .buttonStyle(.primary)
                            .buttonSize(.medium)

                        Button("Small") { }
                            .buttonStyle(.primary)
                            .buttonSize(.small)
                    }
                    .disabled(!isButtonEnabled)
                }
            }

            SectionCard(title: "Secondary") {
                VariantShowcase(
                    title: "Secondary Button",
                    description: "Used for secondary actions"
                ) {
                    VStack(spacing: spacing.md) {
                        Button("Large") { }
                            .buttonStyle(.secondary)
                            .buttonSize(.large)

                        Button("Medium") { }
                            .buttonStyle(.secondary)
                            .buttonSize(.medium)

                        Button("Small") { }
                            .buttonStyle(.secondary)
                            .buttonSize(.small)
                    }
                    .disabled(!isButtonEnabled)
                }
            }

            SectionCard(title: "Tertiary") {
                VariantShowcase(
                    title: "Tertiary Button",
                    description: "Most subtle text style"
                ) {
                    VStack(spacing: spacing.md) {
                        Button("Large") { }
                            .buttonStyle(.tertiary)
                            .buttonSize(.large)

                        Button("Medium") { }
                            .buttonStyle(.tertiary)
                            .buttonSize(.medium)

                        Button("Small") { }
                            .buttonStyle(.tertiary)
                            .buttonSize(.small)
                    }
                    .disabled(!isButtonEnabled)
                }
            }

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
                    Button("Login") { login() }
                        .buttonStyle(.primary)
                        .buttonSize(.large)
                    """)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ButtonCatalogView()
            .theme(ThemeProvider())
    }
}
