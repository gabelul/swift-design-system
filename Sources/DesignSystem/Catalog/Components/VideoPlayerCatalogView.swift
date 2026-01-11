import SwiftUI

#if canImport(UIKit)

/// Catalog view for VideoPlayerView.
struct VideoPlayerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var showPicker = false
    @State private var selectedVideoData: Data?

    var body: some View {
<<<<<<< HEAD
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
=======
        CatalogPageContainer(title: "VideoPlayer") {
            CatalogOverview(description: "動画データまたはURLから動画を再生するコンポーネント")

            SectionCard(title: "デモ") {
                VStack(spacing: spacing.lg) {
                    if let videoData = selectedVideoData {
>>>>>>> upstream/main
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
                                    Text("動画を選択してください")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onSurfaceVariant)
                                }
                            }
                    }

<<<<<<< HEAD
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
=======
                    Button {
                        showPicker = true
                    } label: {
                        Label(
                            selectedVideoData == nil ? "動画を選択" : "動画を変更",
                            systemImage: "video.badge.plus"
                        )
                    }
                    .buttonStyle(.primary)

                    if selectedVideoData != nil {
                        Button {
                            selectedVideoData = nil
                        } label: {
                            Label("クリア", systemImage: "trash")
                        }
                        .buttonStyle(.secondary)
>>>>>>> upstream/main
                    }
                }
                .videoPicker(
                    isPresented: $showPicker,
                    selectedVideoData: $selectedVideoData,
                    maxSize: 100.mb
                )
            }

<<<<<<< HEAD
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
=======
            SectionCard(title: "機能") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    FeatureRow(icon: "play.fill", title: "AVPlayerによる高品質な動画再生")
                    FeatureRow(icon: "info.circle", title: "メタデータ表示（長さ、解像度、サイズ）")
                    FeatureRow(icon: "square.and.arrow.up", title: "共有機能")
                    FeatureRow(icon: "square.and.arrow.down", title: "カメラロールへの保存")
                    FeatureRow(icon: "doc", title: "DataまたはURLから初期化可能")
>>>>>>> upstream/main
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    // 基本的な使い方
                    VideoPlayerView(data: videoData)

                    // メタデータ表示付き
                    VideoPlayerView(data: videoData)
                        .showMetadata(true)

                    // アクションボタン付き
                    VideoPlayerView(data: videoData)
                        .showActions([.play, .share, .saveToPhotos])

                    // URLから再生
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
