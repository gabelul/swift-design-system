import SwiftUI

/// Catalog view for IconPicker (SF Symbols) component
struct IconPickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing

    @State private var selectedIcon: String?
    @State private var showIconPicker = false

    var body: some View {
        CatalogPageContainer(title: "IconPicker") {
            CatalogOverview(description: "Select SF Symbols icon")

            SectionCard(title: "Demo") {
                VStack(spacing: spacing.md) {
                    iconPreview

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

            SectionCard(title: "Usage Examples") {
                CodeExample(code: """
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
            }
        }
    }

    @ViewBuilder
    private var iconPreview: some View {
        HStack(spacing: spacing.md) {
            if let icon = selectedIcon {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundStyle(colors.primary)
                    .frame(width: 50, height: 50)
                    .background(colors.primaryContainer)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                Text(icon)
                    .typography(.bodyMedium)
                    .foregroundStyle(colors.onSurface)
                    .fontDesign(.monospaced)
            } else {
                Text("Please select an icon")
                    .typography(.bodyMedium)
                    .foregroundStyle(colors.onSurfaceVariant)
            }

            Spacer()
        }
        .padding(spacing.md)
        .background(colors.surfaceVariant.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

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
                    IconItem(id: "briefcase", systemName: "briefcase.fill", displayName: "Business"),
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
                    IconItem(id: "envelope", systemName: "envelope.fill", displayName: "Email"),
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
