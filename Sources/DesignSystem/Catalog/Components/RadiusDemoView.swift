import SwiftUI

/// 角丸値のデモコンポーネント
/// 実際の角丸を視覚的にプレビュー
struct RadiusDemoView: View {
    @Environment(\.spacingScale) private var spacing

    let name: String
    let value: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: spacing.sm) {
            HStack {
                Text(name)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Spacer()

                Text(value.isInfinite ? "∞" : "\(Int(value))pt")
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.secondary)
            }

            // 視覚的表現
            RoundedRectangle(cornerRadius: value.isInfinite ? 32 : value)
                .fill(.blue.opacity(0.2))
                .stroke(.blue, lineWidth: 2)
                .frame(height: 64)
        }
        .padding(.vertical, spacing.xs)
    }
}

#Preview {
    List {
        RadiusDemoView(name: "none", value: 0)
        RadiusDemoView(name: "xs", value: 2)
        RadiusDemoView(name: "sm", value: 4)
        RadiusDemoView(name: "md", value: 8)
        RadiusDemoView(name: "lg", value: 12)
        RadiusDemoView(name: "xl", value: 16)
        RadiusDemoView(name: "full", value: .infinity)
    }
}
