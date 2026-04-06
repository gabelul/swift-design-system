import SwiftUI

struct BottomSheetCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @State private var showMedium = false
    @State private var showLarge = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                CatalogOverview(description: "Modal bottom sheet with drag handle and backdrop. Supports small (25%), medium (50%), and large (85%) height presets.")

                SectionCard(title: "Try It") {
                    VStack(spacing: spacing.sm) {
                        Button("Medium Sheet") { showMedium = true }
                            .buttonStyle(.primary)
                        Button("Large Sheet") { showLarge = true }
                            .buttonStyle(.secondary)
                    }
                }

                CodeExample(code: """
                @State var showSheet = false
                
                Button("Open") { showSheet = true }
                    .bottomSheet(isPresented: $showSheet) {
                        Text("Sheet content")
                    }
                
                // Large detent
                    .bottomSheet(isPresented: $show, detent: .large) {
                        ScrollView { ... }
                    }
                """)
            }
            .padding(spacing.lg)
        }
        .background(colors.background)
        .bottomSheet(isPresented: $showMedium, detent: .medium) {
            VStack(alignment: .leading, spacing: spacing.md) {
                Text("Medium Sheet").typography(.titleLarge)
                Text("This takes up 50% of screen height.").typography(.bodyMedium)
            }
        }
        .bottomSheet(isPresented: $showLarge, detent: .large) {
            VStack(alignment: .leading, spacing: spacing.md) {
                Text("Large Sheet").typography(.titleLarge)
                Text("This takes up 85% of screen height.").typography(.bodyMedium)
                Spacer()
            }
        }
        .navigationTitle("BottomSheet")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

#Preview { NavigationStack { BottomSheetCatalogView().theme(ThemeProvider()) } }
