import SwiftUI

#if canImport(UIKit)
import UIKit
import AVKit
import Photos

/// Video player view.
///
/// A component that plays videos from data or URL.
/// Provides playback controls, metadata display, and share/save actions.
///
/// ## Usage
/// ```swift
/// // Play from Data
/// VideoPlayerView(data: videoData)
///
/// // Play from URL
/// VideoPlayerView(url: videoURL)
///
/// // With metadata and actions
/// VideoPlayerView(data: videoData)
///     .showMetadata(true)
///     .showActions([.share, .saveToPhotos])
/// ```
public struct VideoPlayerView: View {
    @Environment(\.colorPalette) private var colorPalette
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    private let source: VideoSource
    private var showMetadata: Bool = false
    private var actions: [VideoPlayerAction] = []

    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var tempFileURL: URL?
    @State private var videoMetadata: VideoMetadata?
    @State private var loadError: Error?
    @State private var showingShareSheet = false
    @State private var snackbarState = SnackbarState()
    @State private var isSaving = false

    // MARK: - Initializers

    /// Initialize from Data.
    ///
    /// - Parameter data: Video data
    public init(data: Data) {
        self.source = .data(data)
    }

    /// Initialize from URL.
    ///
    /// - Parameter url: Video URL (local or remote)
    public init(url: URL) {
        self.source = .url(url)
    }

    // MARK: - Modifiers

    /// Configure metadata display.
    ///
    /// - Parameter show: Whether to show metadata
    /// - Returns: View with the setting applied
    public func showMetadata(_ show: Bool) -> VideoPlayerView {
        var view = self
        view.showMetadata = show
        return view
    }

    /// Configure action buttons.
    ///
    /// - Parameter actions: Actions to display
    /// - Returns: View with the setting applied
    public func showActions(_ actions: [VideoPlayerAction]) -> VideoPlayerView {
        var view = self
        view.actions = actions
        return view
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing.md) {
            // Video player
            playerSection

            // Metadata
            if showMetadata, let metadata = videoMetadata {
                metadataSection(metadata)
            }

            // Action buttons
            if !actions.isEmpty && player != nil {
                actionsSection
            }
        }
        .padding(spacing.md)
        .onAppear {
            setupAudioSession()
            loadVideo()
        }
        .onDisappear {
            player?.pause()
            if !isSaving {
                cleanupTempFile()
            }
        }
        .sheet(isPresented: $showingShareSheet) {
            if let url = tempFileURL ?? source.localURL {
                ShareSheet(items: [url])
            }
        }
        .overlay(alignment: .bottom) {
            Snackbar(state: snackbarState)
        }
    }

    // MARK: - Sections

    @ViewBuilder
    private var playerSection: some View {
        Group {
            if let player = player {
                AVPlayerViewControllerRepresentable(player: player)
                    .frame(minHeight: 200)
            } else if let error = loadError {
                ContentUnavailableView(
                    "Cannot Load Video",
                    systemImage: "video.slash",
                    description: Text(error.localizedDescription)
                )
                .frame(minHeight: 200)
            } else {
                ProgressView("Loading video...")
                    .frame(maxWidth: .infinity, minHeight: 200)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(colorPalette.surfaceVariant))
        .clipShape(RoundedRectangle(cornerRadius: radius.md))
    }

    private func metadataSection(_ metadata: VideoMetadata) -> some View {
        VStack(alignment: .leading, spacing: spacing.xs) {
            Text("Video Info")
                .font(.caption.bold())
                .foregroundStyle(Color(colorPalette.onSurfaceVariant))

            HStack(spacing: spacing.md) {
                if let duration = metadata.duration {
                    Label(formatDuration(duration), systemImage: "clock")
                }
                if let resolution = metadata.resolution {
                    Label(resolution, systemImage: "rectangle")
                }
                Label(metadata.size.formatted, systemImage: "doc")
            }
            .font(.caption)
            .foregroundStyle(Color(colorPalette.onSurfaceVariant))
        }
        .padding(spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(colorPalette.surfaceVariant).opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: radius.sm))
    }

    private var actionsSection: some View {
        HStack(spacing: spacing.sm) {
            if actions.contains(.play) {
                Chip(
                    isPlaying ? "Pause" : "Play",
                    systemImage: isPlaying ? "pause.fill" : "play.fill",
                    action: togglePlayback
                )
                .chipStyle(.outlined)
            }

            if actions.contains(.share) {
                Chip("Share", systemImage: "square.and.arrow.up", action: {
                    showingShareSheet = true
                })
                .chipStyle(.outlined)
            }

            if actions.contains(.saveToPhotos) {
                if isSaving {
                    HStack(spacing: spacing.xs) {
                        ProgressView()
                            .controlSize(.small)
                        Text("Saving...")
                            .typography(.labelMedium)
                            .foregroundStyle(Color(colorPalette.onSurfaceVariant))
                    }
                    .padding(.horizontal, spacing.md)
                    .padding(.vertical, spacing.xs)
                } else {
                    Chip("Save", systemImage: "square.and.arrow.down", action: saveToPhotos)
                        .chipStyle(.filled)
                }
            }
        }
    }

    // MARK: - Private Methods

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }

    private func loadVideo() {
        Task { @MainActor in
            do {
                let url: URL

                switch source {
                case .data(let data):
                    // Save to temporary file
                    let tempDir = FileManager.default.temporaryDirectory
                    let fileURL = tempDir.appendingPathComponent("\(UUID().uuidString).mp4")
                    try data.write(to: fileURL)
                    tempFileURL = fileURL
                    url = fileURL

                    // Extract metadata
                    videoMetadata = await extractMetadata(from: url, dataSize: data.count)

                case .url(let sourceURL):
                    url = sourceURL

                    // Extract metadata
                    if sourceURL.isFileURL {
                        let data = try Data(contentsOf: sourceURL)
                        videoMetadata = await extractMetadata(from: url, dataSize: data.count)
                    } else {
                        videoMetadata = await extractMetadata(from: url, dataSize: nil)
                    }
                }

                player = AVPlayer(url: url)

            } catch {
                loadError = error
            }
        }
    }

    private func extractMetadata(from url: URL, dataSize: Int?) async -> VideoMetadata {
        let asset = AVURLAsset(url: url)

        var duration: TimeInterval?
        var resolution: String?

        // Get video duration
        if let cmDuration = try? await asset.load(.duration) {
            duration = CMTimeGetSeconds(cmDuration)
        }

        // Get resolution
        if let tracks = try? await asset.loadTracks(withMediaType: .video),
           let track = tracks.first,
           let size = try? await track.load(.naturalSize) {
            let width = Int(size.width)
            let height = Int(size.height)
            resolution = "\(width)×\(height)"
        }

        let size = dataSize.map { ByteSize(bytes: $0) } ?? ByteSize(bytes: 0)

        return VideoMetadata(duration: duration, resolution: resolution, size: size)
    }

    private func cleanupTempFile() {
        if let url = tempFileURL {
            try? FileManager.default.removeItem(at: url)
        }
    }

    private func togglePlayback() {
        guard let player = player else { return }

        if isPlaying {
            player.pause()
        } else {
            player.seek(to: .zero)
            player.play()
        }
        isPlaying.toggle()
    }

    private func saveToPhotos() {
        guard let url = tempFileURL ?? source.localURL else {
            snackbarState.show(message: "No video to save")
            return
        }

        guard FileManager.default.fileExists(atPath: url.path) else {
            snackbarState.show(message: "Video file not found")
            return
        }

        isSaving = true

        Task { @MainActor in
            defer { isSaving = false }

            do {
                let status = await PHPhotoLibrary.requestAuthorization(for: .addOnly)

                guard status == .authorized || status == .limited else {
                    snackbarState.show(
                        message: "Photo library access not authorized",
                        primaryAction: SnackbarAction(title: "Open Settings") {
                            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                await UIApplication.shared.open(settingsURL)
                            }
                        },
                        duration: 5.0
                    )
                    return
                }

                let fileURL = url
                try await PHPhotoLibrary.shared().performChanges { @Sendable in
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
                }

                snackbarState.show(message: "Saved to Camera Roll", duration: 3.0)
            } catch {
                snackbarState.show(
                    message: "Failed to save: \(error.localizedDescription)",
                    duration: 5.0
                )
            }
        }
    }

    private func formatDuration(_ seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = seconds >= 3600 ? [.hour, .minute, .second] : [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: seconds) ?? "\(Int(seconds))s"
    }
}

// MARK: - Supporting Types

/// Video player actions.
public enum VideoPlayerAction: Sendable, Hashable {
    /// Play/pause button
    case play
    /// Share button
    case share
    /// Save to Camera Roll
    case saveToPhotos
}

/// Video source.
private enum VideoSource {
    case data(Data)
    case url(URL)

    var localURL: URL? {
        switch self {
        case .url(let url) where url.isFileURL:
            return url
        default:
            return nil
        }
    }
}

/// Video metadata.
private struct VideoMetadata {
    let duration: TimeInterval?
    let resolution: String?
    let size: ByteSize
}

// MARK: - Share Sheet

private struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

private struct AVPlayerViewControllerRepresentable: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.allowsVideoFrameAnalysis = false
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}

#endif
