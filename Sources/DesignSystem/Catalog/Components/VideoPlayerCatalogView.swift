import SwiftUI

#if canImport(UIKit)

/// Catalog view for VideoPlayerView.
struct VideoPlayerCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var showPicker = false
    @State private var selectedVideoData: Data?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Overview
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("A component that plays videos from data or URL.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)

                    Text("Provides playback controls, metadata display, and share/save actions.")
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)
                }

                // Demo
                SectionCard(title: "Demo") {
                    VStack(spacing: spacing.lg) {
                        if let videoData = selectedVideoData {
                            // Player with metadata and actions
                            VideoPlayerView(data: videoData)
                                .showMetadata(true)
                                .showActions([.play, .share, .saveToPhotos])
                        } else {
                            // Placeholder
                            RoundedRectangle(cornerRadius: radius.md)
                                .fill(colorPalette.surfaceVariant)
                                .frame(height: 200)
                                .overlay {
                                    VStack(spacing: spacing.sm) {
                                        Image(systemName: "play.rectangle")
                                            .font(.system(size: 48))
                                            .foregroundStyle(colorPalette.onSurfaceVariant)
                                        Text("Please select a video")
                                            .typography(.bodySmall)
                                            .foregroundStyle(colorPalette.onSurfaceVariant)
                                    }
                                }
                        }

                        // Video selection button
                        Button {
                            showPicker = true
                        } label: {
                            Label(
                                selectedVideoData == nil ? "Select Video" : "Change Video",
                                systemImage: "video.badge.plus"
                            )
                        }
                        .buttonStyle(.primary)

                        // Clear button
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

                // Features
                SectionCard(title: "Features") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        FeatureRow(
                            icon: "play.fill",
                            title: "High-quality video playback with AVPlayer"
                        )
                        FeatureRow(
                            icon: "info.circle",
                            title: "Video metadata display (duration, resolution, size)"
                        )
                        FeatureRow(
                            icon: "square.and.arrow.up",
                            title: "Share functionality"
                        )
                        FeatureRow(
                            icon: "square.and.arrow.down",
                            title: "Save to Camera Roll"
                        )
                        FeatureRow(
                            icon: "doc",
                            title: "Initialize from Data or URL"
                        )
                    }
                }

                // Usage Examples
                SectionCard(title: "Usage Examples") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Play from Data")
                            .typography(.titleSmall)

                        Text("""
                        // Basic usage
                        VideoPlayerView(data: videoData)

                        // With metadata display
                        VideoPlayerView(data: videoData)
                            .showMetadata(true)

                        // With action buttons
                        VideoPlayerView(data: videoData)
                            .showMetadata(true)
                            .showActions([.play, .share, .saveToPhotos])
                        """)
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(spacing.md)
                        .background(colorPalette.surfaceVariant)
                        .clipShape(RoundedRectangle(cornerRadius: radius.sm))

                        Text("Play from URL")
                            .typography(.titleSmall)
                            .padding(.top, spacing.sm)

                        Text("""
                        // Local file URL
                        VideoPlayerView(url: fileURL)

                        // Remote URL
                        VideoPlayerView(url: remoteURL)
                            .showMetadata(true)
                        """)
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(spacing.md)
                        .background(colorPalette.surfaceVariant)
                        .clipShape(RoundedRectangle(cornerRadius: radius.sm))
                    }
                }

                // Actions
                SectionCard(title: "Available Actions") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        ActionItem(
                            icon: "play.fill",
                            name: ".play",
                            description: "Shows play/pause button"
                        )
                        ActionItem(
                            icon: "square.and.arrow.up",
                            name: ".share",
                            description: "Button to show share sheet"
                        )
                        ActionItem(
                            icon: "square.and.arrow.down",
                            name: ".saveToPhotos",
                            description: "Button to save to Camera Roll"
                        )
                    }
                }

                // Best Practices
                SectionCard(title: "Best Practices") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Memory Management",
                            description: "For large videos, play directly from URL to reduce memory usage",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Temporary Files",
                            description: "When playing from Data, temporary files are automatically cleaned up",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "exclamationmark.triangle.fill",
                            title: "Permissions",
                            description: "Saving to Camera Roll requires photo library write permission",
                            isGood: true
                        )
                    }
                }

                // Specifications
                SectionCard(title: "Specifications") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        SpecItem(label: "Input Format", value: "Data or URL")
                        SpecItem(label: "Playback Engine", value: "AVPlayer")
                        SpecItem(label: "Metadata", value: "Duration, Resolution, File Size")
                        SpecItem(label: "Supported Platforms", value: "iOS 17.0+")
                    }
                }
            }
            .padding(.vertical, spacing.lg)
        }
    }
}

// MARK: - Action Item

private struct ActionItem: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing

    let icon: String
    let name: String
    let description: String

    var body: some View {
        HStack(alignment: .top, spacing: spacing.md) {
            Image(systemName: icon)
                .font(.body)
                .foregroundStyle(colorPalette.primary)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: spacing.xxs) {
                Text(name)
                    .typography(.labelMedium)
                    .foregroundStyle(colorPalette.onSurface)

                Text(description)
                    .typography(.bodySmall)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
            }
        }
    }
}

#Preview {
    VideoPlayerCatalogView()
        .theme(ThemeProvider())
}

#endif
