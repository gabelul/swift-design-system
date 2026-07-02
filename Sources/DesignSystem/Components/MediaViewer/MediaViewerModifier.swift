import SwiftUI

// Public API for MediaViewer.
// Reference: ported from Kavsoft's "iOS Photos App Style Transitions Using SwiftUI" (2026-03)
// PhotoGridView grid item side (sourceLocation tracking + fullScreenCover presentation via
// withoutAnimation + hiding the source view), adapted for a single-view target.

extension View {
    /// Opens a full-screen media viewer on tap
    ///
    /// Presents a full-screen viewer with a hero expansion from the thumbnail's
    /// position, pinch-to-zoom, and dismiss via downward drag.
    ///
    /// - Note: Only active on iOS 18 and later. On macOS / tvOS / watchOS and
    ///   iOS 17, nothing is applied (behavior is unchanged).
    ///
    /// - Parameters:
    ///   - item: The media to display on tap
    ///   - enabled: Whether the viewer is enabled (default true)
    /// - Returns: A view with the viewer trigger applied
    @ViewBuilder
    public func mediaViewable(_ item: MediaViewerItem, enabled: Bool = true) -> some View {
        #if os(iOS)
        if #available(iOS 18.0, *) {
            modifier(MediaViewableModifier(item: item, enabled: enabled))
        } else {
            self
        }
        #else
        self
        #endif
    }
}

#if os(iOS)
@available(iOS 18.0, *)
private struct MediaViewableModifier: ViewModifier {
    var item: MediaViewerItem
    var enabled: Bool
    /// View Properties
    @State private var config: MediaViewerConfig = .init()
    func body(content: Content) -> some View {
        content
            /// Hiding the source view when the hero effect is enabled
            .opacity(config.selectedItem == item ? 0 : 1)
            .overlay {
                if enabled {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        let updatedRect: CGRect? = config.selectedItem == item ? rect : nil

                        Color.clear
                            .contentShape(.rect)
                            .onTapGesture {
                                /// Storing info and opening full screen hero view
                                config.selectedItem = item
                                config.sourceLocation = rect
                                /// Opening Full screen cover without animation
                                withoutAnimation {
                                    config.showFullScreenCover = true
                                }
                            }
                            /// Updating the source location when the source view moves
                            .onChange(of: updatedRect) { oldValue, newValue in
                                if let newValue {
                                    config.sourceLocation = newValue
                                }
                            }
                    }
                }
            }
            .fullScreenCover(isPresented: $config.showFullScreenCover) {
                config.selectedItem = nil
            } content: {
                MediaViewerDetailView(config: $config, items: [item])
            }
    }
}
#endif
