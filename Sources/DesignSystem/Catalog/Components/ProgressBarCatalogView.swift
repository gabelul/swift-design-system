import SwiftUI

/// Catalog view for ProgressBar component
struct ProgressBarCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var animatedValue: Double = 0.0

    var body: some View {
        CatalogPageContainer(title: "ProgressBar") {
            CatalogOverview(description: "Bar that visually displays progress")

            SectionCard(title: "Basic") {
                VStack(spacing: spacing.md) {
                    HStack { Text("25%").typography(.labelMedium).frame(width: 40, alignment: .trailing); ProgressBar(value: 0.25) }
                    HStack { Text("50%").typography(.labelMedium).frame(width: 40, alignment: .trailing); ProgressBar(value: 0.5) }
                    HStack { Text("75%").typography(.labelMedium).frame(width: 40, alignment: .trailing); ProgressBar(value: 0.75) }
                    HStack { Text("100%").typography(.labelMedium).frame(width: 40, alignment: .trailing); ProgressBar(value: 1.0) }
                }
            }

            SectionCard(title: "Gradient") {
                VStack(spacing: spacing.md) {
                    ProgressBar(value: 0.7, gradient: LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                    ProgressBar(value: 0.6, gradient: LinearGradient(colors: [.green, .mint], startPoint: .leading, endPoint: .trailing))
                    ProgressBar(value: 0.8, gradient: LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing))
                }
            }

            SectionCard(title: "Sizes") {
                VStack(spacing: spacing.lg) {
                    LabeledVariant(label: "4pt (Slim)") { ProgressBar(value: 0.6, height: 4) }
                    LabeledVariant(label: "8pt (Default)") { ProgressBar(value: 0.6, height: 8) }
                    LabeledVariant(label: "16pt (Large)") { ProgressBar(value: 0.6, height: 16) }
                }
            }

            SectionCard(title: "Colors") {
                VStack(spacing: spacing.md) {
                    ProgressBar(value: 0.5, foregroundColor: colors.secondary, backgroundColor: colors.secondary.opacity(0.2))
                    ProgressBar(value: 0.5, foregroundColor: colors.tertiary, backgroundColor: colors.tertiary.opacity(0.2))
                    ProgressBar(value: 0.5, foregroundColor: colors.error, backgroundColor: colors.error.opacity(0.2))
                }
            }

            SectionCard(title: "Animation") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    ProgressBar(value: animatedValue, height: 12, foregroundColor: colors.primary, animated: true)
                    ProgressBar(value: animatedValue, height: 12, foregroundColor: colors.secondary, animated: true, animation: .spring(duration: 0.5, bounce: 0.3))

                    Button("Run Animation") {
                        animatedValue = animatedValue < 0.5 ? 1.0 : 0.0
                    }
                    .buttonStyle(.primary)
                    .buttonSize(.medium)
                }
            }

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
                    ProgressBar(
                        value: 0.5,
                        gradient: LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        height: 12
                    )
                    """)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProgressBarCatalogView()
            .theme(ThemeProvider())
    }
}
