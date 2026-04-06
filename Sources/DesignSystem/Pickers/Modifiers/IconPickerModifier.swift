import SwiftUI

/// ViewModifier for displaying icon picker (SF Symbols only)
///
/// ## Usage Examples
/// ```swift
/// struct MyView: View {
///     @State private var selectedIcon: String?
///     @State private var showIconPicker = false
///
///     let categories = [
///         IconCategory(
///             id: "general",
///             displayName: "General",
///             icons: [
///                 IconItem(id: "book", systemName: "book.fill", displayName: "Book"),
///                 IconItem(id: "briefcase", systemName: "briefcase.fill", displayName: "Business"),
///             ]
///         )
///     ]
///
///     var body: some View {
///         Button("Select SF Symbols") {
///             showIconPicker = true
///         }
///         .iconPicker(
///             categories: categories,
///             selectedIcon: $selectedIcon,
///             isPresented: $showIconPicker
///         )
///     }
/// }
/// ```
///
/// ## Note
/// This picker is for SF Symbols only. Use `.emojiPicker()` for emojis.
public struct IconPickerModifier: ViewModifier {
    let categories: [any IconCategoryProtocol]
    @Binding var selectedIcon: String?
    @Binding var isPresented: Bool

    public func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                DSIconPickerView(
                    categories: categories,
                    selectedIcon: $selectedIcon,
                    isPresented: $isPresented
                )
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            }
    }
}

// MARK: - View Extension

public extension View {
    /// Displays icon picker
    ///
    /// - Parameters:
    ///   - categories: List of icon categories to display
    ///   - selectedIcon: Value of selected icon
    ///   - isPresented: Picker display state
    /// - Returns: View with icon picker added
    func iconPicker(
        categories: [any IconCategoryProtocol],
        selectedIcon: Binding<String?>,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(IconPickerModifier(
            categories: categories,
            selectedIcon: selectedIcon,
            isPresented: isPresented
        ))
    }
}

// MARK: - Internal View

/// Internal implementation view of icon picker (private)
struct DSIconPickerView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @Environment(\.dismiss) private var dismiss

    let categories: [any IconCategoryProtocol]
    @Binding var selectedIcon: String?
    @Binding var isPresented: Bool

    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search bar
                searchBar
                    .padding(.horizontal, spacing.md)
                    .padding(.vertical, spacing.sm)

                // Icon display by category
                ScrollView {
                    VStack(alignment: .leading, spacing: spacing.lg) {
                        ForEach(Array(filteredCategories.enumerated()), id: \.offset) { index, category in
                            categorySection(category)

                            if index < filteredCategories.count - 1 {
                                Divider()
                                    .padding(.vertical, spacing.sm)
                            }
                        }
                    }
                    .padding(spacing.md)
                }
            }
            .background(colors.background)
            .navigationTitle("Select Icon")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(colors.onSurfaceVariant)
                }

                ToolbarItem(placement: .confirmationAction) {
                    if selectedIcon != nil {
                        Button("Clear") {
                            selectedIcon = nil
                            dismiss()
                        }
                        .foregroundColor(colors.primary)
                    }
                }
            }
        }
    }

    private var searchBar: some View {
        HStack(spacing: spacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16))
                .foregroundColor(colors.onSurfaceVariant)

            TextField("Search icons...", text: $searchText)
                .autocorrectionDisabled()

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundColor(colors.onSurfaceVariant)
                }
            }
        }
        .padding(spacing.sm)
        .background(colors.surfaceVariant.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: radius.sm))
    }

    private func categorySection(_ category: any IconCategoryProtocol) -> some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            Text(category.displayName)
                .font(.headline)
                .foregroundColor(colors.onSurface)

            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: spacing.sm), count: 6),
                spacing: spacing.sm
            ) {
                ForEach(category.icons) { icon in
                    IconPickerButton(
                        icon: icon,
                        isSelected: selectedIcon == icon.systemName,
                        onTap: {
                            selectedIcon = icon.systemName
                            dismiss()
                        }
                    )
                }
            }
        }
    }

    private var filteredCategories: [any IconCategoryProtocol] {
        if searchText.isEmpty {
            return categories
        }

        return categories.compactMap { category -> (any IconCategoryProtocol)? in
            let filteredIcons = category.icons.filter { icon in
                icon.systemName.localizedCaseInsensitiveContains(searchText) ||
                (icon.displayName?.localizedCaseInsensitiveContains(searchText) ?? false)
            }

            if filteredIcons.isEmpty {
                return nil
            }

            return IconCategory(
                id: category.id,
                displayName: category.displayName,
                icons: filteredIcons
            )
        }
    }
}

// MARK: - Icon Picker Button

private struct IconPickerButton: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.radiusScale) private var radius

    let icon: IconItem
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            Image(systemName: icon.systemName)
                .font(.system(size: 24))
                .foregroundStyle(colors.onSurface)
                .frame(width: 50, height: 50)
                .background(
                    isSelected
                        ? colors.primaryContainer
                        : colors.surfaceVariant.opacity(0.5)
                )
                .clipShape(RoundedRectangle(cornerRadius: radius.sm))
                .overlay(
                    RoundedRectangle(cornerRadius: radius.sm)
                        .stroke(
                            isSelected ? colors.primary : Color.clear,
                            lineWidth: 2
                        )
                )
        }
    }
}
