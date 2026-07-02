import SwiftUI

/// Catalog view for MediaViewer
struct MediaViewerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    private let sampleImageURLs: [URL] = [
        URL(string: "https://images.pexels.com/photos/9002742/pexels-photo-9002742.jpeg?cs=srgb&fm=jpg&w=640&h=405")!,
        URL(string: "https://images.pexels.com/photos/7135121/pexels-photo-7135121.jpeg?cs=srgb&fm=jpg&w=640&h=427")!,
        URL(string: "https://images.pexels.com/photos/18873058/pexels-photo-18873058.jpeg?cs=srgb&fm=jpg&w=640&h=450")!
    ]

    private let sampleVideoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!

    var body: some View {
        CatalogPageContainer(title: "MediaViewer") {
            CatalogOverview(description: "A viewer that shows media full-screen on tap. Supports hero expansion, pinch-to-zoom, and drag-down-to-dismiss (iOS 18+).")

            SectionCard(title: "Image Demo") {
                HStack(spacing: spacing.sm) {
                    ForEach(sampleImageURLs, id: \.self) { url in
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(colors.surfaceVariant)
                                .overlay {
                                    ProgressView()
                                }
                        }
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: radius.md))
                        .mediaViewable(.image(url))
                    }
                }
            }

            SectionCard(title: "Video Demo") {
                RoundedRectangle(cornerRadius: radius.md)
                    .fill(colors.surfaceVariant)
                    .frame(height: 120)
                    .overlay {
                        VStack(spacing: spacing.sm) {
                            Image(systemName: "play.rectangle.fill")
                                .font(.system(size: 36))
                                .foregroundStyle(colors.onSurfaceVariant)
                            Text("Tap for full-screen playback")
                                .typography(.bodySmall)
                                .foregroundStyle(colors.onSurfaceVariant)
                        }
                    }
                    .mediaViewable(.video(sampleVideoURL))
            }

            SectionCard(title: "Features") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    FeatureRow(icon: "rectangle.expand.vertical", title: "Hero expansion from the thumbnail's position")
                    FeatureRow(icon: "arrow.up.left.and.arrow.down.right", title: "Two-finger pinch-to-zoom")
                    FeatureRow(icon: "chevron.down", title: "Drag down to dismiss (with background fade)")
                    FeatureRow(icon: "play.rectangle", title: "AVPlayer playback for video and audio")
                    FeatureRow(icon: "iphone", title: "iOS 18+ only — falls back to legacy behavior elsewhere")
                }
            }

            SectionCard(title: "Usage") {
                CodeExample(code: """
                    // Show an image full-screen on tap
                    AsyncImage(url: imageURL) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .mediaViewable(.image(imageURL))

                    // Play a video thumbnail in-app on tap
                    thumbnailView
                        .mediaViewable(.video(videoURL))

                    // Disable (conditionally)
                    imageView
                        .mediaViewable(.image(url), enabled: isViewerEnabled)
                    """)
            }
        }
    }
}

#Preview {
    MediaViewerCatalogView()
        .theme(ThemeProvider())
}
