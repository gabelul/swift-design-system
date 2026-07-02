#if os(iOS)
import SwiftUI
import AVKit

// Full-screen detail view for MediaViewer.
// Reference: ported from Kavsoft's "iOS Photos App Style Transitions Using SwiftUI" (2026-03)
// DetailPhotosView / PanGesture, adapted for an array of MediaViewerItem.
// The image page follows "Multiple Image Viewer - AsyncImage" (2024-12), and the
// video/audio page follows the CustomVideoPlayerView from "Zoom Transitions" (2024-07).

/// State shared between the source view and the viewer
struct MediaViewerConfig {
    var selectedItem: MediaViewerItem?
    var sourceLocation: CGRect = .zero
    var showFullScreenCover: Bool = false
}

@available(iOS 18.0, *)
struct MediaViewerDetailView: View {
    @Binding var config: MediaViewerConfig
    var items: [MediaViewerItem]
    /// View Properties
    @State private var isExpanded: Bool = false
    @State private var viewSize: CGSize = .zero
    @State private var dragOffset: CGSize = .zero
    var body: some View {
        ZoomContainer {
            /// Using Tab View rather than scrollview!
            TabView(selection: $config.selectedItem) {
                ForEach(items) { item in
                    let sourceFrame = config.sourceLocation

                    MediaViewerPage(item: item, isExpanded: isExpanded)
                        .frame(
                            width: isExpanded ? viewSize.width : sourceFrame.width,
                            height: isExpanded ? viewSize.height : sourceFrame.height
                        )
                        .clipped()
                        .offset(
                            x: isExpanded ? 0 : sourceFrame.minX,
                            y: isExpanded ? 0 : sourceFrame.minY
                        )
                        .offset(dragOffset)
                        /// Since the view coordinate system starts at top left
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: isExpanded ? .center : .topLeading
                        )
                        .tag(Optional(item))
                        .ignoresSafeArea()
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            .contentShape(.rect)
            .gesture(
                MediaViewerPanGesture { gesture in
                    let state = gesture.state
                    let translation = gesture.translation(in: gesture.view)

                    if state == .began || state == .changed {
                        dragOffset = .init(width: translation.x, height: translation.y)
                    } else {
                        if dragOffset.height > 50 {
                            dismiss()
                        } else {
                            withAnimation(animation.speed(1.2)) {
                                dragOffset = .zero
                            }
                        }
                    }
                }
            )
            .overlay {
                closeOverlay
                    .compositingGroup()
                    .opacity(interactiveOpacity)
                    .opacity(isExpanded ? 1 : 0)
            }
            .presentationBackground {
                Rectangle()
                    .fill(.black)
                    .opacity(interactiveOpacity)
                    .opacity(isExpanded ? 1 : 0)
            }
            .allowsHitTesting(isExpanded)
            /// Others
            .onGeometryChange(for: CGSize.self, of: {
                $0.size
            }, action: { newValue in
                viewSize = newValue
            })
            .task {
                guard !isExpanded else { return }
                withAnimation(animation) {
                    isExpanded = true
                }
            }
        }
    }

    /// Close button overlay
    private var closeOverlay: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .frame(width: 20, height: 30)
                        .padding(10)
                        .background(.ultraThinMaterial, in: .circle)
                        .contentShape(.rect)
                }

                Spacer(minLength: 0)
            }

            Spacer(minLength: 0)
        }
        .padding(15)
        .environment(\.colorScheme, .dark)
    }

    func dismiss() {
        Task {
            withAnimation(animation.speed(1.2)) {
                dragOffset = .zero
                isExpanded = false
            }

            try? await Task.sleep(for: .seconds(0.35))
            withoutAnimation {
                config.showFullScreenCover = false
            }
        }
    }

    var animation: Animation {
        .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
    }

    /// Fadeout opacity for interactive gesture
    var interactiveOpacity: CGFloat {
        let opacityY = abs(dragOffset.height) / (viewSize.height * 0.3)
        return isExpanded ? (1 - opacityY) : 0
    }
}

/// Page content per media type
@available(iOS 18.0, *)
fileprivate struct MediaViewerPage: View {
    var item: MediaViewerItem
    var isExpanded: Bool
    var body: some View {
        switch item {
        case .image(let url):
            Rectangle()
                .foregroundStyle(.clear)
                .overlay {
                    /// Animations will work even when image is loading
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: isExpanded ? .fit : .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(.gray.opacity(0.4))
                            .overlay {
                                ProgressView()
                                    .tint(.white)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                    }
                }
                .pinchZoom()
        case .video(let url), .audio(let url):
            MediaViewerPlayerPage(url: url)
        }
    }
}

/// Video/audio playback page
@available(iOS 18.0, *)
fileprivate struct MediaViewerPlayerPage: View {
    var url: URL
    @State private var player: AVPlayer?
    var body: some View {
        MediaViewerVideoPlayerView(player: $player)
            .onAppear {
                guard player == nil else { return }
                setupAudioSession()
                player = AVPlayer(url: url)
            }
            .onDisappear {
                player?.pause()
            }
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
}

fileprivate struct MediaViewerVideoPlayerView: UIViewControllerRepresentable {
    @Binding var player: AVPlayer?
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        /// Show playback controls since this is a viewer context, and letterbox to show the full frame
        controller.showsPlaybackControls = true
        controller.videoGravity = .resizeAspect
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}

@available(iOS 18.0, *)
fileprivate struct MediaViewerPanGesture: UIGestureRecognizerRepresentable {
    var handle: (UIPanGestureRecognizer) -> ()
    func makeUIGestureRecognizer(context: Context) -> UIPanGestureRecognizer {
        let gesture = UIPanGestureRecognizer()
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 1
        gesture.delegate = context.coordinator
        return gesture
    }

    func updateUIGestureRecognizer(_ recognizer: UIPanGestureRecognizer, context: Context) {

    }

    func handleUIGestureRecognizerAction(_ recognizer: UIPanGestureRecognizer, context: Context) {
        handle(recognizer)
    }

    func makeCoordinator(converter: CoordinateSpaceConverter) -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UIGestureRecognizerDelegate {
        func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            if let scrollView = otherGestureRecognizer.view as? UIScrollView {
                let contentOffset = scrollView.contentOffset
                return contentOffset.y <= 0
            }

            return false
        }

        func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
            guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
                return false
            }

            let velocity = panGesture.velocity(in: panGesture.view)

            return velocity.y > abs(velocity.x)
        }
    }
}

/// Applies a state change within a transaction that disables animations
func withoutAnimation(_ result: @escaping () -> ()) {
    var transaction = Transaction()
    transaction.disablesAnimations = true
    withTransaction(transaction) {
        result()
    }
}
#endif
