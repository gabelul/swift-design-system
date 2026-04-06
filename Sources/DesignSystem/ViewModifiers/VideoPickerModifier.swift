import SwiftUI

#if canImport(UIKit)
import UIKit
import AVFoundation
import AVKit
import Photos
import PhotosUI
import UniformTypeIdentifiers

/// ViewModifier that presents a video picker.
///
/// Lets the user select a video from the camera or photo library.
/// Handles permissions and shows an alert when access is unavailable.
///
/// - Note: Camera, photo library, and microphone usage descriptions are required.
///   Add the following keys to your Info.plist:
///   - `NSCameraUsageDescription`: explanation for camera usage.
///   - `NSPhotoLibraryUsageDescription`: explanation for photo library usage.
///   - `NSMicrophoneUsageDescription`: explanation for microphone usage (required for video recording).
public struct VideoPickerModifier: ViewModifier {
    @Environment(\.colorPalette) private var colorPalette

    @Binding var isPresented: Bool
    @Binding var selectedVideoData: Data?

    @State private var sourceType: MediaSourceType?
    @State private var showPermissionAlert = false
    @State private var permissionAlertConfig: PermissionAlertConfig?

    let maxSize: ByteSize?
    let maxDuration: TimeInterval?
    let onError: ((VideoPickerError) -> Void)?

    public init(
        isPresented: Binding<Bool>,
        selectedVideoData: Binding<Data?>,
        maxSize: ByteSize? = nil,
        maxDuration: TimeInterval? = nil,
        onError: ((VideoPickerError) -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self._selectedVideoData = selectedVideoData
        self.maxSize = maxSize
        self.maxDuration = maxDuration
        self.onError = onError
    }

    public func body(content: Content) -> some View {
        content
            .confirmationDialog(
                "Select Video",
                isPresented: $isPresented,
                titleVisibility: .visible
            ) {
                // Only show camera if available
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    Button("Record Video") {
                        requestPermissionAndShowPicker(for: .camera)
                    }
                    .tint(Color(colorPalette.primary))
                }

                Button("Choose from Video Library") {
                    requestPermissionAndShowPicker(for: .photoLibrary)
                }
                .tint(Color(colorPalette.primary))

                Button("Cancel", role: .cancel) {
                    isPresented = false
                }
            }
            // Show library picker as sheet
            .sheet(item: Binding(
                get: { sourceType == .photoLibrary ? sourceType : nil },
                set: { sourceType = $0 }
            )) { source in
                VideoPickerViewController(
                    sourceType: source.uiImagePickerSourceType,
                    selectedVideoData: $selectedVideoData,
                    isPresented: $sourceType,
                    maxSize: maxSize,
                    maxDuration: maxDuration,
                    onError: onError
                )
                .ignoresSafeArea()
            }
            // Show camera as full screen (to avoid quality issues on iPad)
            .fullScreenCover(item: Binding(
                get: { sourceType == .camera ? sourceType : nil },
                set: { sourceType = $0 }
            )) { source in
                VideoPickerViewController(
                    sourceType: source.uiImagePickerSourceType,
                    selectedVideoData: $selectedVideoData,
                    isPresented: $sourceType,
                    maxSize: maxSize,
                    maxDuration: maxDuration,
                    onError: onError
                )
                .ignoresSafeArea()
            }
            .alert(
                permissionAlertConfig?.title ?? "",
                isPresented: $showPermissionAlert,
                presenting: permissionAlertConfig
            ) { config in
                if config.canOpenSettings {
                    Button("Open Settings") {
                        openSettings()
                    }
                }
                Button("Cancel", role: .cancel) {
                    isPresented = false
                }
            } message: { config in
                Text(config.message)
            }
    }

    /// Requests permission and shows the picker if allowed.
    private func requestPermissionAndShowPicker(for source: MediaSourceType) {
        Task { @MainActor in
            let hasPermission = await checkPermission(for: source)

            if hasPermission {
                sourceType = source
            } else {
                // If permission is not granted, show an alert
                permissionAlertConfig = PermissionAlertConfig(
                    sourceType: source,
                    status: await getPermissionStatus(for: source)
                )
                showPermissionAlert = true
            }
        }
    }

    /// Checks and, if needed, requests permission.
    private func checkPermission(for source: MediaSourceType) async -> Bool {
        switch source {
        case .camera:
            // Both camera and audio permissions are required
            let cameraPermission = await checkCameraPermission()
            let audioPermission = await checkAudioPermission()
            return cameraPermission && audioPermission
        case .photoLibrary:
            return await checkPhotoLibraryPermission()
        }
    }

    /// Checks and requests camera permission.
    private func checkCameraPermission() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        case .denied:
            return false
        case .restricted:
            return false
        @unknown default:
            return false
        }
    }

    /// Checks and requests microphone permission.
    private func checkAudioPermission() async -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)

        switch status {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .audio)
        case .denied:
            return false
        case .restricted:
            return false
        @unknown default:
            return false
        }
    }

    /// Checks and requests photo library permission.
    private func checkPhotoLibraryPermission() async -> Bool {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)

        switch status {
        case .authorized, .limited:
            return true
        case .notDetermined:
            let newStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            return newStatus == .authorized || newStatus == .limited
        case .denied:
            return false
        case .restricted:
            return false
        @unknown default:
            return false
        }
    }

    /// Returns current permission status.
    private func getPermissionStatus(for source: MediaSourceType) async -> PermissionStatus {
        switch source {
        case .camera:
            let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
            let audioStatus = AVCaptureDevice.authorizationStatus(for: .audio)

            if cameraStatus == .denied || audioStatus == .denied {
                return .denied
            }
            if cameraStatus == .restricted || audioStatus == .restricted {
                return .restricted
            }
            return .notDetermined
        case .photoLibrary:
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch status {
            case .denied:
                return .denied
            case .restricted:
                return .restricted
            default:
                return .notDetermined
            }
        }
    }

    /// Opens the Settings app.
    private func openSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
}

// MARK: - Video Picker Error

/// Video picker errors.
public enum VideoPickerError: LocalizedError, Sendable {
    /// Failed to load video.
    case loadFailed(String)
    /// Video duration exceeded.
    case durationExceeded(actual: TimeInterval, max: TimeInterval)
    /// File size exceeded.
    case sizeExceeded(actual: ByteSize, max: ByteSize)

    public var errorDescription: String? {
        switch self {
        case .loadFailed(let message):
            return "Failed to load video: \(message)"
        case .durationExceeded(let actual, let max):
            return String(format: "Video is too long (%.0f seconds). Maximum is %.0f seconds.", actual, max)
        case .sizeExceeded(let actual, let max):
            return "File size is too large (\(actual.formatted)). Maximum is \(max.formatted)."
        }
    }
}

// MARK: - Video Picker View Controller

/// SwiftUI wrapper for `UIImagePickerController` (for video).
struct VideoPickerViewController: UIViewControllerRepresentable {
    let sourceType: UIImagePickerController.SourceType
    @Binding var selectedVideoData: Data?
    @Binding var isPresented: MediaSourceType?
    let maxSize: ByteSize?
    let maxDuration: TimeInterval?
    let onError: ((VideoPickerError) -> Void)?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.mediaTypes = [UTType.movie.identifier]
        picker.delegate = context.coordinator

        // High quality settings
        picker.videoQuality = .typeHigh
        picker.videoExportPreset = AVAssetExportPreset1920x1080

        // For camera, set video capture mode
        if sourceType == .camera {
            picker.cameraCaptureMode = .video
            // Default to rear camera
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                picker.cameraDevice = .rear
            }

            // Set maximum recording duration
            if let maxDuration = maxDuration {
                picker.videoMaximumDuration = maxDuration
            }
        }

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates required.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: VideoPickerViewController

        init(_ parent: VideoPickerViewController) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            guard let videoURL = info[.mediaURL] as? URL else {
                parent.onError?(.loadFailed("Failed to get video URL"))
                parent.isPresented = nil
                return
            }

            Task { @MainActor in
                do {
                    // Check video duration
                    let asset = AVURLAsset(url: videoURL)
                    let duration = try await asset.load(.duration)
                    let durationSeconds = CMTimeGetSeconds(duration)

                    if let maxDuration = parent.maxDuration, durationSeconds > maxDuration {
                        parent.onError?(.durationExceeded(actual: durationSeconds, max: maxDuration))
                        parent.isPresented = nil
                        return
                    }

                    // Load video data
                    let videoData = try Data(contentsOf: videoURL)

                    // Check size
                    if let maxSize = parent.maxSize, videoData.count > maxSize.bytes {
                        parent.onError?(.sizeExceeded(
                            actual: ByteSize(bytes: videoData.count),
                            max: maxSize
                        ))
                        parent.isPresented = nil
                        return
                    }

                    parent.selectedVideoData = videoData
                    parent.isPresented = nil

                } catch {
                    parent.onError?(.loadFailed(error.localizedDescription))
                    parent.isPresented = nil
                }
            }
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = nil
        }
    }
}

// MARK: - Public Extension

public extension View {
    /// Applies the video picker modifier.
    ///
    /// Presents a video picker from the camera or photo library.
    /// The selected video is returned as `Data`.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var showPicker = false
    ///     @State private var videoData: Data?
    ///
    ///     var body: some View {
    ///         VStack {
    ///             if let videoData {
    ///                 Text("Video size: \(videoData.count) bytes")
    ///             }
    ///
    ///             Button("Select Video") {
    ///                 showPicker = true
    ///             }
    ///         }
    ///         .videoPicker(
    ///             isPresented: $showPicker,
    ///             selectedVideoData: $videoData,
    ///             maxSize: 50.mb,    // 50MB
    ///             maxDuration: 60    // 60 seconds
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls whether the picker is shown.
    ///   - selectedVideoData: Binding that receives the selected video data.
    ///   - maxSize: Optional maximum size. When exceeded, an error is triggered.
    ///   - maxDuration: Optional maximum duration (seconds). Limits camera recording time.
    ///   - onError: Callback invoked when an error occurs.
    /// - Returns: A view with the modifier applied.
    func videoPicker(
        isPresented: Binding<Bool>,
        selectedVideoData: Binding<Data?>,
        maxSize: ByteSize? = nil,
        maxDuration: TimeInterval? = nil,
        onError: ((VideoPickerError) -> Void)? = nil
    ) -> some View {
        modifier(VideoPickerModifier(
            isPresented: isPresented,
            selectedVideoData: selectedVideoData,
            maxSize: maxSize,
            maxDuration: maxDuration,
            onError: onError
        ))
    }
}

#endif
