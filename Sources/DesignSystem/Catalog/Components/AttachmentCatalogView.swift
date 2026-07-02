import SwiftUI

/// Catalog view for the Attachment components (AttachmentThumbnail / AttachmentStrip)
struct AttachmentCatalogView: View {
    @Environment(\.spacingScale) private var spacing

    var body: some View {
        CatalogPageContainer(title: "Attachment") {
            CatalogOverview(description: "A logic-less atom/molecule representing an already-selected attachment. Holds no domain type, state, or IO — removal is a callback, and items are supplied by the caller.")

            SectionCard(title: "Thumbnails") {
                VStack(alignment: .leading, spacing: spacing.lg) {
                    VariantShowcase(title: "Image preview") {
                        AttachmentThumbnail(image: Image(systemName: "photo"), onRemove: {})
                    }

                    Divider()

                    VariantShowcase(title: "File (icon + name)") {
                        HStack(spacing: spacing.sm) {
                            AttachmentThumbnail(
                                systemImage: "doc.text.fill",
                                fileName: "quarterly-report.pdf",
                                onRemove: {}
                            )
                            AttachmentThumbnail(
                                systemImage: "tablecells.fill",
                                fileName: nil,
                                onRemove: {}
                            )
                        }
                    }
                }
            }

            SectionCard(title: "Strip (horizontal scroll)") {
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
                    AttachmentThumbnail(
                        systemImage: "doc.fill",
                        fileName: "spec.md",
                        onRemove: {}
                    )
                }
            }

            SectionCard(title: "Usage") {
                CodeExample(code: """
                    // Horizontal-scrolling container. Items are supplied by the caller.
                    AttachmentStrip {
                        ForEach(attachments) { item in
                            AttachmentThumbnail(image: item.image) {
                                remove(item.id)
                            }
                        }
                    }

                    // File attachment with no preview image
                    AttachmentThumbnail(
                        systemImage: "doc.text",
                        fileName: "report.pdf"
                    ) {
                        remove(fileID)
                    }
                    """)
            }
        }
    }
}

#Preview {
    NavigationStack {
        AttachmentCatalogView()
            .theme(ThemeProvider())
    }
}
