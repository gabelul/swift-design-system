import SwiftUI

/// A pure layout container (molecule) that horizontally scrolls a set of selected attachments.
///
/// The content (the row of thumbnails) is supplied by the caller via a ViewBuilder.
/// This is a fully logic-less layout — it holds no `ForEach`, no items, and no removal logic.
///
/// ```swift
/// AttachmentStrip {
///     ForEach(attachments) { item in
///         AttachmentThumbnail(image: item.image) { remove(item.id) }
///     }
/// }
/// ```
public struct AttachmentStrip<Content: View>: View {
    @Environment(\.spacingScale) private var spacingScale

    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacingScale.sm) {
                content
            }
            .padding(.horizontal, spacingScale.lg)
            .padding(.vertical, spacingScale.sm)
        }
    }
}

#Preview {
    AttachmentStrip {
        AttachmentThumbnail(image: Image(systemName: "photo"), onRemove: {})
        AttachmentThumbnail(
            systemImage: "doc.text.fill",
            fileName: "notes.txt",
            onRemove: {}
        )
        AttachmentThumbnail(
            systemImage: "tablecells.fill",
            fileName: "data.csv",
            onRemove: {}
        )
        AttachmentThumbnail(image: Image(systemName: "photo.fill"), onRemove: {})
    }
    .theme(ThemeProvider())
}
