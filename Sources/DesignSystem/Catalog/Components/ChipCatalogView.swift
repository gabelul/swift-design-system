import SwiftUI

/// Chip component catalog view
///
/// Shows all Chip variations (style, size, state)
/// with live examples and code snippets.
struct ChipCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    @State private var isFilter1Selected = false
    @State private var isFilter2Selected = true
    @State private var isFilter3Selected = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xxl) {
                // Header
                VStack(alignment: .leading, spacing: spacing.sm) {
                    Text("Chip")
                        .typography(.displaySmall)
                        .foregroundColor(colors.onBackground)

                    Text("Compact label component. Useful for statuses, categories, filters, and user input chips.")
                        .typography(.bodyLarge)
                        .foregroundColor(colors.onSurfaceVariant)
                }
                .padding(.horizontal, spacing.lg)

                // Style variants
                sectionCard(title: "Style Variants") {
                    VStack(alignment: .leading, spacing: spacing.lg) {
                        styleVariantRow(
                            title: "Filled",
                            description: "Filled background. Best for statuses and category labels."
                        ) {
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

                        Divider()

                        styleVariantRow(
                            title: "Outlined",
                            description: "Outlined only. Great for filters and secondary categories."
                        ) {
                            Chip("Filter 1", systemImage: "line.3.horizontal.decrease", isSelected: $isFilter1Selected)
                                .chipStyle(.outlined)

                            Chip("Filter 2", systemImage: "tag", isSelected: $isFilter2Selected)
                                .chipStyle(.outlined)

                            Chip("Filter 3", systemImage: "star", isSelected: $isFilter3Selected)
                                .chipStyle(.outlined)
                        }

                        Divider()

                        if #available(iOS 26.0, macOS 26.0, *) {
                            styleVariantRow(
                                title: "Liquid Glass",
                                description: "Translucent glass effect. Ideal for premium-feeling surfaces (iOS 26+)."
                            ) {
                                Chip("Premium", systemImage: "star.fill")
                                    .chipStyle(.liquidGlass)
                                    .foregroundColor(.yellow)

                                Chip("Featured", systemImage: "sparkles")
                                    .chipStyle(.liquidGlass)
                                    .foregroundColor(.purple)

                                Chip("New", systemImage: "bell.fill")
                                    .chipStyle(.liquidGlass)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }

                // Size variants
                sectionCard(title: "Size Variants") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        HStack(spacing: spacing.md) {
                            VStack(alignment: .leading, spacing: spacing.xs) {
                                Text("Medium (デフォルト)")
                                    .typography(.labelMedium)
                                    .foregroundColor(colors.onSurfaceVariant)

                                Text("32pt height. Standard use.")
                                    .typography(.bodySmall)
                                    .foregroundColor(colors.onSurfaceVariant.opacity(0.7))
                            }

                            Spacer()

                            Chip("Medium", systemImage: "tag.fill")
                                .chipStyle(.filled)
                                .chipSize(.medium)
                                .foregroundColor(.blue)
                        }

                        Divider()

                        HStack(spacing: spacing.md) {
                            VStack(alignment: .leading, spacing: spacing.xs) {
                                Text("Small")
                                    .typography(.labelMedium)
                                    .foregroundColor(colors.onSurfaceVariant)

                                Text("24pt高さ、密集レイアウト向け")
                                    .typography(.bodySmall)
                                    .foregroundColor(colors.onSurfaceVariant.opacity(0.7))
                            }

                            Spacer()

                            Chip("Small", systemImage: "tag.fill")
                                .chipStyle(.filled)
                                .chipSize(.small)
                                .foregroundColor(.blue)
                        }
                    }
                }

                // Input Chips (Deletable)
                sectionCard(title: "Input Chip（削除可能）") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("ユーザー入力されたタグやトークンの表示に使用")
                            .typography(.bodyMedium)
                            .foregroundColor(colors.onSurfaceVariant)

                        FlowLayout(spacing: spacing.sm) {
                            Chip("SwiftUI", systemImage: "tag.fill") {
                                print("Delete SwiftUI")
                            }
                            .chipStyle(.filled)
                            .foregroundColor(.blue)

                            Chip("iOS Development") {
                                print("Delete iOS Development")
                            }
                            .chipStyle(.filled)
                            .foregroundColor(.purple)

                            Chip("Design System", systemImage: "paintbrush.fill") {
                                print("Delete Design System")
                            }
                            .chipStyle(.filled)
                            .foregroundColor(.pink)
                        }
                    }
                }

                // Use cases
                sectionCard(title: "Use Cases") {
                    VStack(alignment: .leading, spacing: spacing.lg) {
                        useCaseRow(title: "Status chips") {
                            HStack(spacing: spacing.sm) {
                                Chip("Active", systemImage: "circle.fill")
                                    .chipStyle(.filled)
                                    .chipSize(.small)
                                    .foregroundColor(.green)

                                Chip("In Progress", systemImage: "arrow.circlepath")
                                    .chipStyle(.filled)
                                    .chipSize(.small)
                                    .foregroundColor(.blue)

                                Chip("Completed", systemImage: "checkmark.circle.fill")
                                    .chipStyle(.filled)
                                    .chipSize(.small)
                                    .foregroundColor(.gray)
                            }
                        }

                        Divider()

                        useCaseRow(title: "Category tags") {
                            FlowLayout(spacing: spacing.xs) {
                                Chip("Technology", systemImage: "laptopcomputer")
                                    .chipStyle(.outlined)
                                    .chipSize(.small)

                                Chip("Design", systemImage: "paintpalette")
                                    .chipStyle(.outlined)
                                    .chipSize(.small)

                                Chip("Business", systemImage: "briefcase")
                                    .chipStyle(.outlined)
                                    .chipSize(.small)

                                Chip("Science", systemImage: "atom")
                                    .chipStyle(.outlined)
                                    .chipSize(.small)
                            }
                        }

                        Divider()

                        useCaseRow(title: "Filters") {
                            FlowLayout(spacing: spacing.sm) {
                                Chip("All Items", systemImage: "square.grid.2x2", isSelected: .constant(true))
                                    .chipStyle(.outlined)

                                Chip("Favorites", systemImage: "star", isSelected: .constant(false))
                                    .chipStyle(.outlined)

                                Chip("Recent", systemImage: "clock", isSelected: .constant(false))
                                    .chipStyle(.outlined)
                            }
                        }
                    }
                }

                // Best practices
                sectionCard(title: "Best Practices") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Use in the right places",
                            description: "Use for statuses, categories, filters, tags, and other concise information.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Clear labels",
                            description: "Use short, clear labels (1–2 words). Avoid long strings.",
                            isGood: true
                        )

                        BestPracticeItem(
                            icon: "xmark.circle.fill",
                            title: "Overuse",
                            description: "Too many chips create visual noise. Limit usage to important information.",
                            isGood: false
                        )

                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Consistent styling",
                            description: "Use a consistent style within the same context. Avoid mixing Filled and Outlined.",
                            isGood: true
                        )
                    }
                }
            }
            .padding(.vertical, spacing.xl)
        }
    }

    // MARK: - Helper Views

    private func sectionCard<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        SectionCard(title: title, elevation: .level1) {
            content()
        }
        .padding(.horizontal, spacing.lg)
    }

    private func styleVariantRow<Content: View>(
        title: String,
        description: String,
        @ViewBuilder chips: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            VStack(alignment: .leading, spacing: spacing.xs) {
                Text(title)
                    .typography(.titleMedium)
                    .foregroundColor(colors.onSurface)

                Text(description)
                    .typography(.bodyMedium)
                    .foregroundColor(colors.onSurfaceVariant)
            }

            HStack(spacing: spacing.sm) {
                chips()
            }
        }
    }

    private func useCaseRow<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            Text(title)
                .typography(.labelLarge)
                .foregroundColor(colors.onSurface)

            content()
        }
    }
}

// MARK: - Flow Layout

/// チップを水平に並べ、スペースがなくなったら次の行に折り返すレイアウト
private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX, y: bounds.minY + result.frames[index].minY), proposal: .unspecified)
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
                    // New line
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

// MARK: - Previews

#Preview {
    ChipCatalogView()
}
