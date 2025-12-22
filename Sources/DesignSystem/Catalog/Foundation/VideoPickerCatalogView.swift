import SwiftUI

#if canImport(UIKit)

/// Catalog view for the video picker modifier.
struct VideoPickerCatalogView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var showPicker = false
    @State private var selectedVideoData: Data?
    @State private var errorMessage: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing.xl) {
                // Overview
                VStack(alignment: .leading, spacing: spacing.md) {
                    Text("A modifier that allows selecting videos from the camera or video library.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)

                    Text("Handles permissions appropriately and allows setting size and duration limits.")
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)
                }

                // Demo
                SectionCard(title: "Demo") {
                    VStack(spacing: spacing.lg) {
                        // Display selected video
                        if let videoData = selectedVideoData {
                            VideoPlayerView(data: videoData)
                                .showMetadata(true)
                                .showActions([.share, .saveToPhotos])
                                .frame(height: 280)
                        } else {
                            RoundedRectangle(cornerRadius: radius.md)
                                .fill(colorPalette.surfaceVariant)
                                .frame(height: 200)
                                .overlay {
                                    VStack(spacing: spacing.sm) {
                                        Image(systemName: "video")
                                            .font(.system(size: 48))
                                            .foregroundStyle(colorPalette.onSurfaceVariant)
                                        Text("No video selected")
                                            .typography(.bodySmall)
                                            .foregroundStyle(colorPalette.onSurfaceVariant)
                                    }
                                }
                        }

                        // Error message
                        if let error = errorMessage {
                            Text(error)
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.error)
                                .padding(spacing.sm)
                                .background(colorPalette.errorContainer)
                                .clipShape(RoundedRectangle(cornerRadius: radius.sm))
                        }

                        // Video selection button
                        Button {
                            showPicker = true
                            errorMessage = nil
                        } label: {
                            Label(
                                selectedVideoData == nil ? "Select Video" : "Change Video",
                                systemImage: "video"
                            )
                        }
                        .buttonStyle(.primary)

                        // Clear button (only when video is selected)
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
                        maxSize: 50.mb,
                        maxDuration: 60
                    ) { error in
                        errorMessage = error.localizedDescription
                    }
                }

                // Features
                SectionCard(title: "Features") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        FeatureRow(
                            icon: "video.fill",
                            title: "Record new video with camera"
                        )
                        FeatureRow(
                            icon: "photo.on.rectangle",
                            title: "Select from existing videos"
                        )
                        FeatureRow(
                            icon: "timer",
                            title: "Maximum recording duration limit"
                        )
                        FeatureRow(
                            icon: "doc.fill",
                            title: "File size limit"
                        )
                        FeatureRow(
                            icon: "lock.shield.fill",
                            title: "Proper permission requests and error handling"
                        )
                    }
                }

                // Usage Example
                SectionCard(title: "Usage Example") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Basic Usage")
                            .typography(.titleSmall)

                        Text("""
                        struct ContentView: View {
                            @State private var showPicker = false
                            @State private var videoData: Data?

                            var body: some View {
                                VStack {
                                    if let videoData {
                                        VideoPlayerView(data: videoData)
                                    }

                                    Button("Select Video") {
                                        showPicker = true
                                    }
                                }
                                .videoPicker(
                                    isPresented: $showPicker,
                                    selectedVideoData: $videoData,
                                    maxSize: 50.mb,
                                    maxDuration: 60
                                )
                            }
                        }
                        """)
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(spacing.md)
                        .background(colorPalette.surfaceVariant)
                        .clipShape(RoundedRectangle(cornerRadius: radius.sm))
                    }
                }

                // Info.plist Configuration
                SectionCard(title: "Info.plist Configuration") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("The following keys must be added to Info.plist:")
                            .typography(.bodyMedium)

                        VStack(alignment: .leading, spacing: spacing.sm) {
                            InfoRow(
                                label: "NSCameraUsageDescription",
                                value: "Describe reason for camera access"
                            )
                            InfoRow(
                                label: "NSPhotoLibraryUsageDescription",
                                value: "Describe reason for photo library access"
                            )
                            InfoRow(
                                label: "NSMicrophoneUsageDescription",
                                value: "Describe reason for microphone access (required for video recording)"
                            )
                        }
                        .padding(spacing.md)
                        .background(colorPalette.surfaceVariant)
                        .clipShape(RoundedRectangle(cornerRadius: radius.sm))
                    }
                }

                // Best Practices
                SectionCard(title: "Best Practices") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "ByteSize Type",
                            description: "Use the intuitive ByteSize type for file size limits (e.g., 50.mb)",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Duration Limit",
                            description: "Use maxDuration to limit maximum recording time for camera capture",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "exclamationmark.triangle.fill",
                            title: "Memory Management",
                            description: "Video files can be large, so set appropriate size limits",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "exclamationmark.triangle.fill",
                            title: "Simulator Limitation",
                            description: "Camera is not available in the simulator; testing on a real device is recommended",
                            isGood: true
                        )
                    }
                }

                // Specifications
                SectionCard(title: "Specifications") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        SpecItem(label: "Return Value", value: "Data?")
                        SpecItem(label: "Required Permissions", value: "Camera, Microphone, Photo Library")
                        SpecItem(label: "Supported Platforms", value: "iOS 17.0+")
                        SpecItem(label: "Size Limit", value: "Specify with ByteSize type")
                        SpecItem(label: "Duration Limit", value: "Specify with TimeInterval (seconds)")
                    }
                }
            }
            .padding(.vertical, spacing.lg)
        }
    }
}

#Preview {
    VideoPickerCatalogView()
        .theme(ThemeProvider())
}

#endif
