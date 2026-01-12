import SwiftUI

/// Catalog view for Chip component
struct ChipCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    @State private var isFilter1Selected = false
    @State private var isFilter2Selected = true
    @State private var isFilter3Selected = false

    var body: some View {
        CatalogPageContainer(title: "Chip") {
            CatalogOverview(description: "Compact label component. Used for various purposes such as status, categories, and filters.")

            SectionCard(title: "Styles") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    VariantShowcase(title: "Filled", description: "Best for status and category labels") {
                        HStack(spacing: spacing.sm) {
                            Chip("Active", systemImage: "circle.fill")
                                .chipStyle(.filled)
                                .foregroundColor(.green)
                            Chip("Pending", systemImage: "clock.fill")
                                .chipStyle(.filled)
                                .foregroundColor(.orange)
                            Chip("Error", systemImage: "exclamationmark.triangle.fill")
                                .chipStyle(.filled)
                                .foregroundColor(.red)
                        }
                    }

                    Divider()

                    VariantShowcase(title: "Outlined", description: "Best for filter selection and secondary categories") {
                        HStack(spacing: spacing.sm) {
                            Chip("Filter 1", systemImage: "line.3.horizontal.decrease", isSelected: $isFilter1Selected)
                                .chipStyle(.outlined)
                            Chip("Filter 2", systemImage: "tag", isSelected: $isFilter2Selected)
                                .chipStyle(.outlined)
                            Chip("Filter 3", systemImage: "star", isSelected: $isFilter3Selected)
                                .chipStyle(.outlined)
                        }
                    }

                    if #available(iOS 26.0, macOS 26.0, *) {
                        Divider()

                        VariantShowcase(title: "Liquid Glass", description: "Premium expression (iOS 26+)") {
                            HStack(spacing: spacing.sm) {
                                Chip("Premium", systemImage: "star.fill")
                                    .chipStyle(.liquidGlass)
                                    .foregroundColor(.yellow)
                                Chip("Featured", systemImage: "sparkles")
                                    .chipStyle(.liquidGlass)
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                }
            }

            SectionCard(title: "Sizes") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    VariantShowcase(title: "Medium", description: "32pt height, standard usage") {
                        Chip("Medium", systemImage: "tag.fill")
                            .chipStyle(.filled)
                            .chipSize(.medium)
                            .foregroundColor(.blue)
                    }

                    Divider()

                    VariantShowcase(title: "Small", description: "24pt height, for dense layouts") {
                        Chip("Small", systemImage: "tag.fill")
                            .chipStyle(.filled)
                            .chipSize(.small)
                            .foregroundColor(.blue)
                    }
                }
            }

            SectionCard(title: "Removable") {
                VariantShowcase(title: "Input Chip", description: "Display user-input tags") {
                    FlowLayout(spacing: spacing.sm) {
                        Chip("SwiftUI", systemImage: "tag.fill", onDelete: {})
                            .chipStyle(.filled)
                            .foregroundColor(.blue)
                        Chip("iOS Development", onDelete: {})
                            .chipStyle(.filled)
                            .foregroundColor(.purple)
                        Chip("Design System", systemImage: "paintbrush.fill", onDelete: {})
                            .chipStyle(.filled)
                            .foregroundColor(.pink)
                    }
                }
            }

            SectionCard(title: "Use Cases") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    VariantShowcase(title: "Status Display") {
                        HStack(spacing: spacing.sm) {
                            Chip("Active", systemImage: "circle.fill")
                                .chipStyle(.filled).chipSize(.small).foregroundColor(.green)
                            Chip("In Progress", systemImage: "arrow.circlepath")
                                .chipStyle(.filled).chipSize(.small).foregroundColor(.blue)
                            Chip("Completed", systemImage: "checkmark.circle.fill")
                                .chipStyle(.filled).chipSize(.small).foregroundColor(.gray)
                        }
                    }

                    Divider()

                    VariantShowcase(title: "Category Tags") {
                        FlowLayout(spacing: spacing.xs) {
                            Chip("Technology", systemImage: "laptopcomputer").chipStyle(.outlined).chipSize(.small)
                            Chip("Design", systemImage: "paintpalette").chipStyle(.outlined).chipSize(.small)
                            Chip("Business", systemImage: "briefcase").chipStyle(.outlined).chipSize(.small)
                        }
                    }

                    Divider()

                    VariantShowcase(title: "Filters") {
                        FlowLayout(spacing: spacing.sm) {
                            Chip("All Items", systemImage: "square.grid.2x2", isSelected: .constant(true)).chipStyle(.outlined)
                            Chip("Favorites", systemImage: "star", isSelected: .constant(false)).chipStyle(.outlined)
                            Chip("Recent", systemImage: "clock", isSelected: .constant(false)).chipStyle(.outlined)
                        }
                    }
                }
            }

            SectionCard(title: "Best Practices") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Concise Labels",
                        description: "Use short, clear 1-2 word labels",
                        isGood: true
                    )
                    BestPracticeItem(
                        icon: "checkmark.circle.fill",
                        title: "Style Consistency",
                        description: "Use the same style within the same context",
                        isGood: true
                    )
                    BestPracticeItem(
                        icon: "xmark.circle.fill",
                        title: "Avoid Overuse",
                        description: "Too many chips on screen creates visual noise",
                        isGood: false
                    )
                }
            }
        }
    }
}

/// Layout that arranges chips horizontally and wraps
private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.replacingUnspecifiedDimensions().width, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            subview.place(
                at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY),
                proposal: .unspecified
            )
        }
    }

    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var x: CGFloat = 0
            var y: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                if x + size.width > maxWidth && x > 0 {
                    x = 0
                    y += lineHeight + spacing
                    lineHeight = 0
                }
                frames.append(CGRect(origin: CGPoint(x: x, y: y), size: size))
                lineHeight = max(lineHeight, size.height)
                x += size.width + spacing
            }
            self.size = CGSize(width: maxWidth, height: y + lineHeight)
        }
    }
}

#Preview {
    ChipCatalogView()
        .theme(ThemeProvider())
}
