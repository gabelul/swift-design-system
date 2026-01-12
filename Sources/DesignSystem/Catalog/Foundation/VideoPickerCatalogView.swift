import SwiftUI

#if canImport(UIKit)

/// Catalog view for video picker modifier
struct VideoPickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var showPicker = false
    @State private var selectedVideoData: Data?
    @State private var errorMessage: String?

    var body: some View {
        CatalogPageContainer(title: "VideoPicker") {
            CatalogOverview(description: "A modifier for selecting videos from camera or video library")

            SectionCard(title: "Demo") {
                VStack(spacing: spacing.lg) {
                    if let videoData = selectedVideoData {
                        VideoPlayerView(data: videoData)
                            .showMetadata(true)
                            .showActions([.share, .saveToPhotos])
                            .frame(height: 280)
                    } else {
                        RoundedRectangle(cornerRadius: radius.md)
                            .fill(colors.surfaceVariant)
                            .frame(height: 200)
                            .overlay {
                                VStack(spacing: spacing.sm) {
                                    Image(systemName: "video")
                                        .font(.system(size: 48))
                                        .foregroundStyle(colors.onSurfaceVariant)
                                    Text("Please select a video")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onSurfaceVariant)
                                }
                            }
                    }

                    if let error = errorMessage {
                        Text(error)
                            .typography(.bodySmall)
                            .foregroundStyle(colors.error)
                            .padding(spacing.sm)
                            .background(colors.errorContainer)
                            .clipShape(RoundedRectangle(cornerRadius: radius.sm))
                    }

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

            SectionCard(title: "Features") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    FeatureRow(icon: "video.fill", title: "Capture new video with camera")
                    FeatureRow(icon: "photo.on.rectangle", title: "Select from existing videos")
                    FeatureRow(icon: "timer", title: "Maximum recording duration limit")
                    FeatureRow(icon: "doc.fill", title: "File size limit")
                    FeatureRow(icon: "lock.shield.fill", title: "Appropriate permission requests")
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    @State private var showPicker = false
                    @State private var videoData: Data?

                    Button("Select Video") {
                        showPicker = true
                    }
                    .videoPicker(
                        isPresented: $showPicker,
                        selectedVideoData: $videoData,
                        maxSize: 50.mb,
                        maxDuration: 60
                    )
                    """)
            }

            SectionCard(title: "Info.plist Settings") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    InfoRow(label: "NSCameraUsageDescription", value: "Reason for camera access")
                    InfoRow(label: "NSPhotoLibraryUsageDescription", value: "Reason for photo library access")
                    InfoRow(label: "NSMicrophoneUsageDescription", value: "Reason for microphone access")
                }
            }

            SectionCard(title: "Specifications") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    SpecItem(label: "Return Value", value: "Data?")
                    SpecItem(label: "Required Permissions", value: "Camera, Microphone, Photo Library")
                    SpecItem(label: "Supported Platforms", value: "iOS 17.0+")
                    SpecItem(label: "Size Limit", value: "Specified with ByteSize type")
                    SpecItem(label: "Time Limit", value: "TimeInterval (seconds)")
                }
            }
        }
    }
}

#Preview {
    VideoPickerCatalogView()
        .theme(ThemeProvider())
}

#endif
