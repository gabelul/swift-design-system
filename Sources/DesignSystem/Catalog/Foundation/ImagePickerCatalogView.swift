import SwiftUI

#if canImport(UIKit)

/// Image picker modifier catalog view
struct ImagePickerCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius

    @State private var showPicker = false
    @State private var selectedImageData: Data?

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Overview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Modifier that lets you select images from the camera or photo library.")
                        .typography(.bodyMedium)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)

                    Text("Handles permissions correctly and shows alerts when access is not granted.")
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(.horizontal, spacing.lg)
                }

                // Demo
                SectionCard(title: "Demo") {
                    VStack(spacing: spacing.lg) {
                        // Selected image preview
                        if let imageData = selectedImageData,
                           let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(colorPalette.surfaceVariant)
                                .frame(height: 200)
                                .overlay {
                                    VStack(spacing: spacing.sm) {
                                        Image(systemName: "photo")
                                            .font(.system(size: 48))
                                            .foregroundStyle(colorPalette.onSurfaceVariant)
                                        Text("No image selected")
                                            .typography(.bodySmall)
                                            .foregroundStyle(colorPalette.onSurfaceVariant)
                                    }
                                }
                        }

                        // Select image button
                        Button {
                            showPicker = true
                        } label: {
                            Label(
                                selectedImageData == nil ? "Select Image" : "Change Image",
                                systemImage: "photo"
                            )
                        }
                        .buttonStyle(.primary)

                        // Clear button (only when image is selected)
                        if selectedImageData != nil {
                            Button {
                                selectedImageData = nil
                            } label: {
                                Label("Clear", systemImage: "trash")
=======
        CatalogPageContainer(title: "ImagePicker") {
            CatalogOverview(description: "カメラまたは写真ライブラリから画像を選択するモディファイア")

            SectionCard(title: "デモ") {
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
                                    Text("画像を選択してください")
                                        .typography(.bodySmall)
                                        .foregroundStyle(colors.onSurfaceVariant)
                                }
>>>>>>> upstream/main
                            }
                    }

                    Button {
                        showPicker = true
                    } label: {
                        Label(
                            selectedImageData == nil ? "画像を選択" : "画像を変更",
                            systemImage: "photo"
                        )
                    }
                    .buttonStyle(.primary)

                    if selectedImageData != nil {
                        Button {
                            selectedImageData = nil
                        } label: {
                            Label("クリア", systemImage: "trash")
                        }
                        .buttonStyle(.secondary)
                    }
                }
                .imagePicker(
                    isPresented: $showPicker,
                    selectedImageData: $selectedImageData
                )
            }

            SectionCard(title: "機能") {
                VStack(alignment: .leading, spacing: spacing.md) {
                    FeatureRow(icon: "camera.fill", title: "カメラで新しい写真を撮影")
                    FeatureRow(icon: "photo.fill", title: "既存の写真から選択")
                    FeatureRow(icon: "lock.shield.fill", title: "適切な権限リクエストとエラーハンドリング")
                    FeatureRow(icon: "gearshape.fill", title: "権限拒否時は設定画面へ誘導")
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    @State private var showPicker = false
                    @State private var imageData: Data?

                    Button("画像を選択") {
                        showPicker = true
                    }
                    .imagePicker(
                        isPresented: $showPicker,
                        selectedImageData: $imageData,
                        maxSize: 1.mb
                    )
                    """)
            }

<<<<<<< HEAD
                // Features
                SectionCard(title: "Features") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                            FeatureRow(
                                icon: "camera.fill",
                                title: "Capture a new photo with the camera"
                            )
                            FeatureRow(
                                icon: "photo.fill",
                                title: "Pick from existing photos"
                            )
                            FeatureRow(
                                icon: "lock.shield.fill",
                                title: "Proper permission requests and error handling"
                            )
                            FeatureRow(
                                icon: "gearshape.fill",
                                title: "Guides the user to Settings when access is denied"
                        )
                    }
                }

                // Usage
                SectionCard(title: "Usage") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("Basic usage")
                            .typography(.titleSmall)

                        Text("""
                        struct ContentView: View {
                            @State private var showPicker = false
                            @State private var imageData: Data?

                            var body: some View {
                                VStack {
                                    if let imageData,
                                       let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 200)
                                    }

                                    Button("Select Image") {
                                        showPicker = true
                                    }
                                }
                                .imagePicker(
                                    isPresented: $showPicker,
                                    selectedImageData: $imageData,
                                    maxSize: 1.mb  // 1MB
                                )
                            }
                        }
                        """)
                        .typography(.bodySmall)
                        .foregroundStyle(colorPalette.onSurfaceVariant)
                        .padding(spacing.md)
                        .background(colorPalette.surfaceVariant)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Info.plist setup
                SectionCard(title: "Info.plist configuration") {
                    VStack(alignment: .leading, spacing: spacing.md) {
                        Text("You need to add the following keys to Info.plist:")
                            .typography(.bodyMedium)

                        VStack(alignment: .leading, spacing: spacing.sm) {
                            InfoRow(
                                label: "NSCameraUsageDescription",
                                value: "Explain why the app needs access to the camera."
                            )
                            InfoRow(
                                label: "NSPhotoLibraryUsageDescription",
                                value: "Explain why the app needs access to the photo library."
                            )
                        }
                        .padding(spacing.md)
                        .background(colorPalette.surfaceVariant)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Best practices
                SectionCard(title: "Best practices") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Image format",
                            description: "Selected images are returned as JPEG Data (80% quality).",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "exclamationmark.triangle.fill",
                            title: "Simulator limitations",
                            description: "The camera is not available in the simulator, so testing on a real device is recommended.",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "checkmark.circle.fill",
                            title: "Permission requests",
                            description: "Permission prompts are shown only once. If denied, an alert will guide users to the Settings app.",
                            isGood: true
                        )
                        BestPracticeItem(
                            icon: "exclamationmark.triangle.fill",
                            title: "Memory management",
                            description: "Image data is kept in memory, so consider compressing or resizing large images.",
                            isGood: true
                        )
                    }
                }

                // Specifications
                SectionCard(title: "Specifications") {
                    VStack(alignment: .leading, spacing: spacing.sm) {
                        SpecItem(label: "Return type", value: "Data? (JPEG)")
                        SpecItem(label: "JPEG quality", value: "80%")
                        SpecItem(label: "Required permissions", value: "Camera, Photo Library")
                        SpecItem(label: "Supported platforms", value: "iOS 17.0+")
                    }
=======
            SectionCard(title: "Info.plist設定") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    InfoRow(label: "NSCameraUsageDescription", value: "カメラへのアクセス理由")
                    InfoRow(label: "NSPhotoLibraryUsageDescription", value: "写真ライブラリへのアクセス理由")
                }
            }

            SectionCard(title: "仕様") {
                VStack(alignment: .leading, spacing: spacing.sm) {
                    SpecItem(label: "戻り値", value: "Data? (JPEG形式)")
                    SpecItem(label: "JPEG品質", value: "80%")
                    SpecItem(label: "必要な権限", value: "カメラ、写真ライブラリ")
                    SpecItem(label: "対応プラットフォーム", value: "iOS 17.0+")
>>>>>>> upstream/main
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
