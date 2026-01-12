import SwiftUI

#if canImport(UIKit)

/// Catalog view for image picker modifier
struct ImagePickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var showPicker = false
    @State private var selectedImageData: Data?

    var body: some View {
        CatalogPageContainer(title: "ImagePicker") {
            CatalogOverview(description: "A modifier for selecting images from camera or photo library")

            SectionCard(title: "Demo") {
                VStack(spacing: spacing.lg) {
                    if let imageData = selectedImageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                            .clipShape(RoundedRectangle(cornerRadius: radius.md))
                    } else {
                        RoundedRectangle(cornerRadius: radius.md)
                            .fill(colors.surfaceVariant)
                            .frame(height: 200)
                            .overlay {
                                VStack(spacing: spacing.sm) {
                                    Image(systemName: "photo")
                                        .font(.system(size: 48))
                                        .foregroundStyle(colors.onSurfaceVariant)
                                    Text("Please select an image")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onSurfaceVariant)
                                }
                            }
                    }

                    Button {
                        showPicker = true
                    } label: {
                        Label(
                            selectedImageData == nil ? "Select Image" : "Change Image",
                            systemImage: "photo"
                        )
                    }
                    .buttonStyle(.primary)

                    if selectedImageData != nil {
                        Button {
                            selectedImageData = nil
                        } label: {
                            Label("Clear", systemImage: "trash")
                        }
                        .buttonStyle(.secondary)
                    }
                }
                .imagePicker(
                    isPresented: $showPicker,
                    selectedImageData: $selectedImageData
                )
            }

            SectionCard(title: "Features") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    FeatureRow(icon: "camera.fill", title: "Capture new photo with camera")
                    FeatureRow(icon: "photo.fill", title: "Select from existing photos")
                    FeatureRow(icon: "lock.shield.fill", title: "Appropriate permission requests and error handling")
                    FeatureRow(icon: "gearshape.fill", title: "Guide to settings when permission denied")
                }
            }

            SectionCard(title: "Usage Example") {
                CodeExample(code: """
                    @State private var showPicker = false
                    @State private var imageData: Data?

                    Button("Select Image") {
                        showPicker = true
                    }
                    .imagePicker(
                        isPresented: $showPicker,
                        selectedImageData: $imageData,
                        maxSize: 1.mb
                    )
                    """)
            }

            SectionCard(title: "Info.plist Settings") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    InfoRow(label: "NSCameraUsageDescription", value: "Reason for camera access")
                    InfoRow(label: "NSPhotoLibraryUsageDescription", value: "Reason for photo library access")
                }
            }

            SectionCard(title: "Specifications") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    SpecItem(label: "Return Value", value: "Data? (JPEG format)")
                    SpecItem(label: "JPEG Quality", value: "80%")
                    SpecItem(label: "Required Permissions", value: "Camera, Photo Library")
                    SpecItem(label: "Supported Platforms", value: "iOS 17.0+")
                }
            }
        }
    }
}

#Preview {
    ImagePickerCatalogView()
        .theme(ThemeProvider())
}

#endif
