import SwiftUI

/// A segmented control whose selection indicator slides using Liquid Glass.
///
/// Unlike `SegmentedControl`'s flat color swap, the selected segment is rendered as a single
/// glass capsule that glides with `matchedGeometryEffect`. The indicator also tracks the
/// finger during a drag. Falls back to `ultraThinMaterial` below iOS 26.
public struct GlassSegmentedControl<Selection: Hashable, Content: View>: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacingScale
    @Environment(\.motion) private var motion
    @Namespace private var indicatorNamespace

    private let selection: Binding<Selection>
    private let options: [Selection]
    private let content: (Selection) -> Content

    @State private var trackWidth: CGFloat = 0

    public init(
        selection: Binding<Selection>,
        options: [Selection],
        @ViewBuilder content: @escaping (Selection) -> Content
    ) {
        self.selection = selection
        self.options = options
        self.content = content
    }

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                segment(for: option)
            }
        }
        .padding(spacingScale.xs)
        .background(colorPalette.surfaceVariant.opacity(0.6), in: Capsule())
        .overlay {
            Capsule().stroke(colorPalette.outlineVariant, lineWidth: 1)
        }
        .contentShape(Capsule())
        .onGeometryChange(for: CGFloat.self) {
            $0.size.width
        } action: { newValue in
            trackWidth = newValue
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { select(at: $0.location.x) }
                .onEnded { select(at: $0.location.x) }
        )
        .sensoryFeedback(.selection, trigger: selection.wrappedValue)
        .accessibilityRepresentation {
            Picker("", selection: selection) {
                ForEach(options, id: \.self) { option in
                    content(option).tag(option)
                }
            }
        }
    }

    private func segment(for option: Selection) -> some View {
        let isSelected = selection.wrappedValue == option
        return content(option)
            .typography(.labelMedium)
            .fontWeight(isSelected ? .semibold : .regular)
            .foregroundStyle(isSelected ? colorPalette.primary : colorPalette.onSurfaceVariant)
            .frame(maxWidth: .infinity)
            .frame(height: 36)
            .background {
                if isSelected {
                    indicator
                        .matchedGeometryEffect(id: "indicator", in: indicatorNamespace)
                }
            }
    }

    @ViewBuilder private var indicator: some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            Capsule()
                .fill(colorPalette.primary.opacity(0.05))
                .glassEffect(.regular.tint(colorPalette.primary.opacity(0.18)).interactive(true), in: Capsule())
        } else {
            Capsule()
                .fill(colorPalette.primary.opacity(0.06))
                .background(.ultraThinMaterial, in: Capsule())
        }
    }

    /// Selects the segment whose equal-width index matches the tap/drag position.
    private func select(at x: CGFloat) {
        guard trackWidth > 0, !options.isEmpty else { return }
        let segmentWidth = trackWidth / CGFloat(options.count)
        let index = min(options.count - 1, max(0, Int(x / segmentWidth)))
        let option = options[index]
        guard selection.wrappedValue != option else { return }
        withAnimation(motion.spring) {
            selection.wrappedValue = option
        }
    }
}

#Preview {
    @Previewable @State var selection = "Single"

    VStack(spacing: 24) {
        GlassSegmentedControl(selection: $selection, options: ["Single", "Paging", "Chat"]) { option in
            Text(option)
        }
    }
    .padding()
    .theme(ThemeProvider())
}
