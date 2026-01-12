import SwiftUI

#if canImport(UIKit)

/// Catalog view for VideoPlayerView
struct VideoPlayerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var showPicker = false
    @State private var selectedVideoData: Data?

    var body: some View {
        CatalogPageContainer(title: "VideoPlayer") {
            CatalogOverview(description: "Component that plays videos from data or URL")

            SectionCard(title: "Demo") {
                VStack(spacing: spacing.lg) {
                    if let videoData = selectedVideoData {
                        VideoPlayerView(data: videoData)
                            .showMetadata(true)
                            .showActions([.play, .share, .saveToPhotos])
                    } else {
                        RoundedRectangle(cornerRadius: radius.md)
                            .fill(colors.surfaceVariant)
                            .frame(height: 200)
                            .overlay {
                                VStack(spacing: spacing.sm) {
                                    Image(systemName: "play.rectangle")
                                        .font(.system(size: 48))
                                        .foregroundStyle(colors.onSurfaceVariant)
                                    Text("Please select a video")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onSurfaceVariant)
                                }
                            }
                    }

                    Button {
                        showPicker = true
                    } label: {
                        Label(
                            selectedVideoData == nil ? "Select Video" : "Change Video",
                            systemImage: "video.badge.plus"
                        )
                    }
                    .buttonStyle(.primary)

                    if selectedVideoData != nil {
                        Button {
                            selectedVideoData = nil
                        } label: {
                            Label("Clear", systemImage: "trash")
                        }
                        .buttonStyle(.secondary)
                    }
                }
                .videoPicker(
                    isPresented: $showPicker,
                    selectedVideoData: $selectedVideoData,
                    maxSize: 100.mb
                )
            }

            SectionCard(title: "Features") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    FeatureRow(icon: "play.fill", title: "High-quality video playback with AVPlayer")
                    FeatureRow(icon: "info.circle", title: "Metadata display (duration, resolution, size)")
                    FeatureRow(icon: "square.and.arrow.up", title: "Share functionality")
                    FeatureRow(icon: "square.and.arrow.down", title: "Save to camera roll")
                    FeatureRow(icon: "doc", title: "Can be initialized from Data or URL")
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    // Basic usage
                    VideoPlayerView(data: videoData)

                    // With metadata display
                    VideoPlayerView(data: videoData)
                        .showMetadata(true)

                    // With action buttons
                    VideoPlayerView(data: videoData)
                        .showActions([.play, .share, .saveToPhotos])

                    // Play from URL
                    VideoPlayerView(url: fileURL)
                    """)
            }
        }
    }
}

#Preview {
    VideoPlayerCatalogView()
        .theme(ThemeProvider())
}

#endif
