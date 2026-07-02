import Foundation

/// A single piece of media shown in the full-screen media viewer
///
/// Pass this to the `mediaViewable(_:enabled:)` modifier to specify which
/// media opens in the full-screen viewer on tap.
///
/// ## Usage
/// ```swift
/// AsyncImage(url: imageURL) { image in
///     image.resizable().scaledToFit()
/// } placeholder: {
///     ProgressView()
/// }
/// .mediaViewable(.image(imageURL))
/// ```
public enum MediaViewerItem: Hashable, Identifiable, Sendable {
    /// Image (remote http/https or file URL, resolved via AsyncImage)
    case image(URL)
    /// Video (played via AVPlayer)
    case video(URL)
    /// Audio (played via AVPlayer)
    case audio(URL)

    public var id: URL { url }

    /// The media's URL
    public var url: URL {
        switch self {
        case .image(let url), .video(let url), .audio(let url):
            return url
        }
    }
}
