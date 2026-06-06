import SwiftUI

public extension View {
    /// Liquid Glass のサーフェス背景を敷く。カード・行・コンポーザーなどの面に使う。
    ///
    /// iOS 26 未満では ultraThinMaterial + アウトラインにフォールバックします。
    /// - Parameters:
    ///   - cornerRadius: 角丸半径。
    ///   - tint: ガラスに重ねるティント色。
    ///   - interactive: タッチに反応するガラスにするか。
    func glassSurface(cornerRadius: CGFloat = 16, tint: Color? = nil, interactive: Bool = false) -> some View {
        modifier(GlassSurfaceModifier(cornerRadius: cornerRadius, tint: tint, interactive: interactive))
    }
}

struct GlassSurfaceModifier: ViewModifier {
    @Environment(\.colorPalette) private var colorPalette
    let cornerRadius: CGFloat
    let tint: Color?
    let interactive: Bool

    func body(content: Content) -> some View {
        if #available(iOS 26.0, macOS 26.0, *) {
            content.glassEffect(glass, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            content
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(colorPalette.outlineVariant, lineWidth: 1)
                }
        }
    }

    @available(iOS 26.0, macOS 26.0, *)
    private var glass: Glass {
        var glass: Glass = .regular
        if let tint { glass = glass.tint(tint) }
        if interactive { glass = glass.interactive() }
        return glass
    }
}
