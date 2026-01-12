import SwiftUI

/// Color swatch component
/// Displays color + HEX code + token name, and copies HEX code on tap
struct ColorSwatchView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    let name: String
    let color: Color
    let hexCode: String?
    let description: String?

    @State private var showCopiedFeedback = false

    init(name: String, color: Color, hexCode: String? = nil, description: String? = nil) {
        self.name = name
        self.color = color
        self.hexCode = hexCode
        self.description = description
    }

    var body: some View {
        Button {
            copyToClipboard()
        } label: {
            HStack(spacing: spacing.md) {
                // 色見本
                RoundedRectangle(cornerRadius: radius.sm)
