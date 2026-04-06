import SwiftUI

#if canImport(UIKit)
import UIKit
import AVFoundation
import Photos
import PhotosUI

/// ViewModifier that presents an image picker.
///
/// Lets the user select an image from the camera or photo library.
/// Handles permissions and shows an alert when access is unavailable.
///
/// - Note: Camera and photo library usage descriptions are required.
///   Add the following keys to your Info.plist:
///   - `NSCameraUsageDescription`: explanation for camera usage.
///   - `NSPhotoLibraryUsageDescription`: explanation for photo library usage.
public struct ImagePickerModifier: ViewModifier {
    @Environment(\.colorPalette) private var colorPalette

    @Binding var isPresented: Bool
    @Binding var selectedImageData: Data?

    @State private var sourceType: MediaSourceType?
    @State private var showPermissionAlert = false
    @State private var permissionAlertConfig: PermissionAlertConfig?

    let maxSize: ByteSize?
    let onCompressionError: ((Error) -> Void)?

    public init(
        isPresented: Binding<Bool>,
        selectedImageData: Binding<Data?>,
        maxSize: ByteSize? = nil,
        onCompressionError: ((Error) -> Void)? = nil
    ) {
        self._isPresented = isPresented
        self._selectedImageData = selectedImageData
        self.maxSize = maxSize
        self.onCompressionError = onCompressionError
    }

    public func body(content: Content) -> some View {
        content
            .confirmationDialog(
                "Select Image",
                isPresented: $isPresented,
                titleVisibility: .visible
            ) {
                // Only show camera if available
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    Button("Take Photo") {
                        requestPermissionAndShowPicker(for: .camera)
                    }
                    .tint(Color(colorPalette.primary))
                }

                Button("Choose from Photo Library") {
                    requestPermissionAndShowPicker(for: .photoLibrary)
                }
                .tint(Color(colorPalette.primary))

                Button("Cancel", role: .cancel) {
                    isPresented = false
                }
            }
            .sheet(item: $sourceType) { source in
                ImagePickerViewController(
                    sourceType: source.uiImagePickerSourceType,
                    selectedImageData: $selectedImageData,
                    isPresented: $sourceType,
                    maxSize: maxSize,
                    onCompressionError: onCompressionError
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
            return await checkCameraPermission()
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
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status {
            case .denied:
                return .denied
            case .restricted:
                return .restricted
            default:
                return .notDetermined
            }
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

// MARK: - Shared Types

/// Media source type
enum MediaSourceType: Identifiable {
    case camera
    case photoLibrary

    var id: String {
        switch self {
        case .camera: return "camera"
        case .photoLibrary: return "photoLibrary"
        }
    }

    var uiImagePickerSourceType: UIImagePickerController.SourceType {
        switch self {
        case .camera: return .camera
        case .photoLibrary: return .photoLibrary
        }
    }
}

/// Permission state
enum PermissionStatus {
    case notDetermined
    case denied
    case restricted
}

/// Configuration for permission alerts.
struct PermissionAlertConfig {
    let title: String
    let message: String
    let canOpenSettings: Bool

    init(sourceType: MediaSourceType, status: PermissionStatus) {
        switch sourceType {
        case .camera:
            self.title = "Camera Access Required"
            switch status {
            case .denied:
                self.message = "Please allow camera access in Settings."
                self.canOpenSettings = true
            case .restricted:
                self.message = "Camera access is restricted. Check device restrictions or parental controls."
                self.canOpenSettings = false
            case .notDetermined:
                self.message = "Camera access is required to take photos."
                self.canOpenSettings = false
            }
        case .photoLibrary:
            self.title = "Photo Access Required"
            switch status {
            case .denied:
                self.message = "Please allow photo access in Settings."
                self.canOpenSettings = true
            case .restricted:
                self.message = "Photo access is restricted. Check device restrictions or parental controls."
                self.canOpenSettings = false
            case .notDetermined:
                self.message = "Photo library access is required to pick images."
                self.canOpenSettings = false
            }
        }
    }
}

/// SwiftUI wrapper for `UIImagePickerController`.
struct ImagePickerViewController: UIViewControllerRepresentable {
    let sourceType: UIImagePickerController.SourceType
    @Binding var selectedImageData: Data?
    @Binding var isPresented: MediaSourceType?
    let maxSize: ByteSize?
    let onCompressionError: ((Error) -> Void)?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates required.
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerViewController

        init(_ parent: ImagePickerViewController) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                // Convert image to JPEG data
                if let maxSize = parent.maxSize {
                    // If there is a size limit, compress recursively
                    parent.selectedImageData = compressImageData(image, maxSize: maxSize)
                } else {
                    // If there is no size limit, convert with default quality
                    parent.selectedImageData = image.jpegData(compressionQuality: 0.8)
                }

                // Error handling
                if parent.selectedImageData == nil {
                    let error = NSError(
                        domain: "ImagePickerError",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Failed to convert image."]
                    )
                    parent.onCompressionError?(error)
                }
            }
            parent.isPresented = nil
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = nil
        }

        /// Recursively compresses an image to be under the specified size.
        /// - Parameters:
        ///   - image: The image to compress.
        ///   - maxSize: Maximum allowed size.
        ///   - currentQuality: Current JPEG quality (0.0–1.0).
        /// - Returns: Compressed image data, or nil if conversion fails.
        private func compressImageData(
            _ image: UIImage,
            maxSize: ByteSize,
            currentQuality: CGFloat = 0.8
        ) -> Data? {
            guard let data = image.jpegData(compressionQuality: currentQuality) else {
                return nil
            }

            // Already under the limit, return as is.
            if data.count <= maxSize.bytes {
                return data
            }

            // If quality reached the lower bound, return current data.
            if currentQuality <= 0.1 {
                return data
            }

            // Lower quality by 10% and retry.
            return compressImageData(image, maxSize: maxSize, currentQuality: currentQuality - 0.1)
        }
    }
}

// MARK: - Public Extension

public extension View {
    /// Applies the image picker modifier.
    ///
    /// Presents an image picker from the camera or photo library.
    /// The selected image is returned as JPEG `Data`.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var showPicker = false
    ///     @State private var imageData: Data?
    ///
    ///     var body: some View {
    ///         VStack {
    ///             if let imageData, let uiImage = UIImage(data: imageData) {
    ///                 Image(uiImage: uiImage)
    ///                     .resizable()
    ///                     .scaledToFit()
    ///                     .frame(height: 200)
    ///             }
    ///
    ///             Button("Select Image") {
    ///                 showPicker = true
    ///             }
    ///         }
    ///         .imagePicker(
    ///             isPresented: $showPicker,
    ///             selectedImageData: $imageData,
    ///             maxSize: 1.mb  // 1MB
    ///         )
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - isPresented: Binding that controls whether the picker is shown.
    ///   - selectedImageData: Binding that receives the selected image data.
    ///   - maxSize: Optional maximum size. When specified, the image is automatically compressed.
    ///   - onCompressionError: Callback invoked when compression or conversion fails.
    /// - Returns: A view with the modifier applied.
    func imagePicker(
        isPresented: Binding<Bool>,
        selectedImageData: Binding<Data?>,
        maxSize: ByteSize? = nil,
        onCompressionError: ((Error) -> Void)? = nil
    ) -> some View {
        modifier(ImagePickerModifier(
            isPresented: isPresented,
            selectedImageData: selectedImageData,
            maxSize: maxSize,
            onCompressionError: onCompressionError
        ))
    }
}

#endif
