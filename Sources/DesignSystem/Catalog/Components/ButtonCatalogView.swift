import SwiftUI

/// Button component catalog view
struct ButtonCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @State private var isButtonEnabled = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Overview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Explore button styles and sizes.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)

                    Toggle("Enable buttons", isOn: $isButtonEnabled)
                        .padding(.horizontal, spacing.lg)
                }

                // Primary Button
                SectionCard(title: "Primary Button") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Most prominent button. Use for primary actions.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.md) {
                            Button("Large (default)") { }
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

                // Secondary Button
                SectionCard(title: "Secondary Button") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Use for secondary actions with less emphasis than primary.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.md) {
                            Button("Large (default)") { }
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

                // Tertiary Button
                SectionCard(title: "Tertiary Button") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Least prominent button. Text-only style.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.md) {
                            Button("Large (default)") { }
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

                // Usage
                SectionCard(title: "Usage") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to use in SwiftUI")
                            .typography(.titleSmall)

                        Text("""
                        Button("Log in") {
                            login()
                        }
                        .buttonStyle(.primary)
                        .buttonSize(.large)
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.bottom, spacing.xl)
        }
        .background(colorPalette.background)
        .navigationTitle("Button")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview {
    NavigationStack {
        ButtonCatalogView()
            .theme(ThemeProvider())
    }
}
