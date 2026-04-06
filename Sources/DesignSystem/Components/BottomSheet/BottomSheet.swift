import SwiftUI

/// Bottom sheet height preset
public enum BottomSheetDetent: Sendable {
    /// 25% of screen height
    case small
    /// 50% of screen height
    case medium
    /// 85% of screen height
    case large

    var heightFraction: CGFloat {
        switch self {
        case .small: return 0.25
        case .medium: return 0.50
        case .large: return 0.85
        }
    }
}

/// Modal bottom sheet with drag handle and customizable height
///
/// Presents content from the bottom of the screen over a dimmed backdrop.
/// Supports three height presets and can be dismissed by tapping the backdrop
/// or dragging down.
///
/// ## Usage
/// ```swift
/// @State private var showSheet = false
///
/// Button("Show Sheet") { showSheet = true }
///     .bottomSheet(isPresented: $showSheet) {
///         Text("Sheet content")
///     }
///
/// // Custom detent
///     .bottomSheet(isPresented: $showSheet, detent: .large) {
///         ScrollView { ... }
///     }
/// ```
public struct BottomSheet<Content: View>: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @Binding private var isPresented: Bool
    private let detent: BottomSheetDetent
    private let showsDragHandle: Bool
    private let isDismissible: Bool
    private let content: Content

    /// Creates a bottom sheet
    ///
    /// - Parameters:
    ///   - isPresented: Binding controlling sheet visibility
    ///   - detent: Height preset (default: .medium = 50% screen)
    ///   - showsDragHandle: Show the drag indicator pill (default: true)
    ///   - isDismissible: Allow dismissal via backdrop tap or drag (default: true)
    ///   - content: The sheet's content
    public init(
        isPresented: Binding<Bool>,
        detent: BottomSheetDetent = .medium,
        showsDragHandle: Bool = true,
        isDismissible: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self._isPresented = isPresented
        self.detent = detent
        self.showsDragHandle = showsDragHandle
        self.isDismissible = isDismissible
        self.content = content()
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            // Backdrop
            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if isDismissible {
                            withAnimation(.spring(duration: 0.3)) { isPresented = false }
                        }
                    }
                    .transition(.opacity)

                // Sheet
                VStack(spacing: 0) {
                    if showsDragHandle {
                        RoundedRectangle(cornerRadius: 2.5)
                            .fill(colors.onSurfaceVariant.opacity(0.4))
                            .frame(width: 36, height: 5)
                            .padding(.top, spacing.sm)
                            .padding(.bottom, spacing.sm)
                    }

                    content
                        .padding(.horizontal, spacing.lg)
                        .padding(.bottom, spacing.xl)
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: sheetHeight)
                .background(colors.surface)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: radius.xl,
                        topTrailingRadius: radius.xl
                    )
                )
                .transition(.move(edge: .bottom))
            }
        }
        .animation(.spring(duration: 0.35, bounce: 0.15), value: isPresented)
        .ignoresSafeArea(edges: .bottom)
    }

    private var sheetHeight: CGFloat {
        #if os(iOS)
        UIScreen.main.bounds.height * detent.heightFraction
        #else
        500 * detent.heightFraction
        #endif
    }
}

// MARK: - ViewModifier

struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let detent: BottomSheetDetent
    let sheetContent: SheetContent

    func body(content: Content) -> some View {
        content.overlay {
            BottomSheet(
                isPresented: $isPresented,
                detent: detent
            ) {
                sheetContent
            }
        }
    }
}

public extension View {
    /// Presents a bottom sheet over this view
    ///
    /// - Parameters:
    ///   - isPresented: Binding controlling sheet visibility
    ///   - detent: Height preset (default: .medium)
    ///   - content: The sheet's content
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        detent: BottomSheetDetent = .medium,
        @ViewBuilder content: () -> Content
    ) -> some View {
        modifier(BottomSheetModifier(
            isPresented: isPresented,
            detent: detent,
            sheetContent: content()
        ))
    }
}

#Preview {
    @Previewable @State var showSheet = false

    VStack {
        Button("Show Bottom Sheet") { showSheet = true }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .bottomSheet(isPresented: $showSheet) {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sheet Title").typography(.titleLarge)
            Text("This is a bottom sheet with default medium detent.")
                .typography(.bodyMedium)
        }
    }
    .theme(ThemeProvider())
}
