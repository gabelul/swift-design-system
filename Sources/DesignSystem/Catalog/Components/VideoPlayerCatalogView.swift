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
        CatalogPageContainer(title: "VideoPlayer") {
            CatalogOverview(description: "動画データまたはURLから動画を再生するコンポーネント")

            SectionCard(title: "デモ") {
                VStack(spacing: spacing.lg) {
                    if let videoData = selectedVideoData {
