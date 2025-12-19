import SwiftUI

/// IconPicker (SF Symbols) catalog view
struct IconPickerCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    @State private var selectedIcon: String?
    @State private var showIconPicker = false

    var body: some View {
        ScrollView {
            VStack(spacing: spacing.xl) {
                // Header
                headerSection

                // Basic usage example
                basicUsageSection

                // Code example
                codeExampleSection
            }
            .padding(spacing.lg)
        }
        .background(colorPalette.background)
        .navigationTitle("IconPicker")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }

    private var headerSection: some View {
        VStack(spacing: spacing.md) {
            Image(systemName: "square.grid.3x3")
                .font(.system(size: 48))
                .foregroundStyle(colorPalette.primary)

            Text("IconPicker")
                .typography(.headlineLarge)
                .foregroundStyle(colorPalette.onBackground)

            Text("Select SF Symbols icons")
                .typography(.bodyMedium)
                .foregroundStyle(colorPalette.onSurfaceVariant)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private var basicUsageSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Basic usage example")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)

            Text("SF Symbols picker organized by category")
                .typography(.bodySmall)
                .foregroundStyle(colorPalette.onSurfaceVariant)

            VStack(spacing: spacing.md) {
                // Selected icon preview
                HStack(spacing: spacing.md) {
                    if let icon = selectedIcon {
                        Image(systemName: icon)
                            .font(.system(size: 32))
                            .foregroundStyle(colorPalette.primary)
                            .frame(width: 50, height: 50)
                            .background(colorPalette.primaryContainer)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Selected icon")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)
                            Text(icon)
                                .typography(.bodyMedium)
                                .foregroundStyle(colorPalette.onSurface)
                                .fontDesign(.monospaced)
                        }
                    } else {
                        Text("Please select an icon")
                            .typography(.bodyMedium)
                            .foregroundStyle(colorPalette.onSurfaceVariant)
                    }

                    Spacer()
                }
                .padding(spacing.md)
                .background(colorPalette.surfaceVariant.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // Select button
                Button(selectedIcon == nil ? "Select Icon" : "Change Icon") {
                    showIconPicker = true
                }
                .buttonStyle(.primary)
                .buttonSize(.medium)
                .iconPicker(
                    categories: sampleSFSymbolsCategories,
                    selectedIcon: $selectedIcon,
                    isPresented: $showIconPicker
                )
            }
        }
    }

    private var codeExampleSection: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            Text("Code example")
                .typography(.titleLarge)
                .foregroundStyle(colorPalette.onSurface)

            VStack(alignment: .leading, spacing: spacing.sm) {
                codeBlock("""
                    @State private var selectedIcon: String?
                    @State private var showIconPicker = false

                    let categories = [
                        IconCategory(
                            id: "general",
                            displayName: "General",
                            icons: [
                                IconItem(id: "book", systemName: "book.fill"),
                                IconItem(id: "heart", systemName: "heart.fill")
                            ]
                        )
                    ]

                    Button("Select Icon") {
                        showIconPicker = true
                    }
                    .iconPicker(
                        categories: categories,
                        selectedIcon: $selectedIcon,
                        isPresented: $showIconPicker
                    )
                    """)

                Text("Categories and icons:")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.top, spacing.sm)

                Text("• IconCategory - Defines a category")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                Text("• IconItem - Defines individual SF Symbols")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)

                Text("• systemName - SF Symbols name (e.g., \"star.fill\")")
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
            }
        }
    }

    private func codeBlock(_ code: String) -> some View {
        Text(code)
            .typography(.bodySmall)
            .fontDesign(.monospaced)
            .foregroundStyle(colorPalette.onSurface)
            .padding(spacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorPalette.surfaceVariant.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    // Sample categories: SF Symbols
    private var sampleSFSymbolsCategories: [IconCategory] {
        [
            IconCategory(
                id: "general",
                displayName: "General",
                icons: [
                    IconItem(id: "book", systemName: "book.fill", displayName: "Book"),
                    IconItem(id: "heart", systemName: "heart.fill", displayName: "Heart"),
                    IconItem(id: "star", systemName: "star.fill", displayName: "Star"),
                    IconItem(id: "flag", systemName: "flag.fill", displayName: "Flag"),
                    IconItem(id: "tag", systemName: "tag.fill", displayName: "Tag"),
                    IconItem(id: "bookmark", systemName: "bookmark.fill", displayName: "Bookmark")
                ]
            ),
            IconCategory(
                id: "business",
                displayName: "Business",
                icons: [
                    IconItem(id: "briefcase", systemName: "briefcase.fill", displayName: "Briefcase"),
                    IconItem(id: "folder", systemName: "folder.fill", displayName: "Folder"),
                    IconItem(id: "doc", systemName: "doc.fill", displayName: "Document"),
                    IconItem(id: "calendar", systemName: "calendar", displayName: "Calendar"),
                    IconItem(id: "clock", systemName: "clock.fill", displayName: "Clock"),
                    IconItem(id: "chart", systemName: "chart.bar.fill", displayName: "Chart")
                ]
            ),
            IconCategory(
                id: "communication",
                displayName: "Communication",
                icons: [
                    IconItem(id: "message", systemName: "message.fill", displayName: "Message"),
                    IconItem(id: "phone", systemName: "phone.fill", displayName: "Phone"),
                    IconItem(id: "envelope", systemName: "envelope.fill", displayName: "Mail"),
                    IconItem(id: "bubble", systemName: "bubble.left.fill", displayName: "Bubble"),
                    IconItem(id: "bell", systemName: "bell.fill", displayName: "Notification"),
                    IconItem(id: "paperplane", systemName: "paperplane.fill", displayName: "Send")
                ]
            )
        ]
    }
}

#Preview {
    NavigationStack {
        IconPickerCatalogView()
            .theme(ThemeProvider())
    }
}
