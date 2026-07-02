import SwiftUI

/// Catalog view for the StepIndicator component
struct StepIndicatorCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    @State private var demoIndex: Int? = 0

    var body: some View {
        CatalogPageContainer(title: "StepIndicator") {
            CatalogOverview(description: "A compact indicator showing the current position across N forward-only steps as a row of dots. Used for phase progression, such as plan → work → assemble.")

            SectionCard(title: "States") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    VariantShowcase(title: "In progress", description: "Current = primary, passed = faint primary, upcoming = outlineVariant") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            StepIndicator(stepCount: 3, currentIndex: 0)
                            StepIndicator(stepCount: 3, currentIndex: 1)
                            StepIndicator(stepCount: 3, currentIndex: 2)
                        }
                    }

                    Divider()

                    VariantShowcase(title: "Completed (currentIndex: nil)") {
                        StepIndicator(stepCount: 3, currentIndex: nil)
                    }

                    Divider()

                    VariantShowcase(title: "Step count and dot diameter variants") {
                        VStack(alignment: .leading, spacing: spacing.md) {
                            StepIndicator(stepCount: 5, currentIndex: 2)
                            StepIndicator(stepCount: 4, currentIndex: 1, dotDiameter: 8)
                        }
                    }
                }
            }

            SectionCard(title: "Interactive demo") {
                VStack(spacing: spacing.lg) {
                    StepIndicator(stepCount: 4, currentIndex: demoIndex, dotDiameter: 8)
                    Button("Next Step") {
                        switch demoIndex {
                        case .some(let index) where index < 3: demoIndex = index + 1
                        case .some: demoIndex = nil
                        case nil: demoIndex = 0
                        }
                    }
                    .buttonStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    NavigationStack {
        StepIndicatorCatalogView()
            .theme(ThemeProvider())
    }
}
