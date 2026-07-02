import XCTest
@testable import DesignSystem

final class MediaViewerItemTests: XCTestCase {
    func testIdReturnsAssociatedURL() {
        let url = URL(string: "https://example.com/photo.jpg")!

        XCTAssertEqual(MediaViewerItem.image(url).id, url)
        XCTAssertEqual(MediaViewerItem.video(url).id, url)
        XCTAssertEqual(MediaViewerItem.audio(url).id, url)
    }

    func testURLAccessor() {
        let url = URL(string: "https://example.com/movie.mp4")!

        XCTAssertEqual(MediaViewerItem.video(url).url, url)
    }

    func testAcceptsFileURL() {
        // Local file URLs are accepted too (supports local images referenced from Markdown)
        let fileURL = URL(fileURLWithPath: "/tmp/sample.png")
        let item = MediaViewerItem.image(fileURL)

        XCTAssertEqual(item.url, fileURL)
        XCTAssertTrue(item.url.isFileURL)
    }

    func testHashableDistinguishesCases() {
        let url = URL(string: "https://example.com/media")!

        // Different item when the type differs, even with the same URL
        XCTAssertNotEqual(MediaViewerItem.image(url), MediaViewerItem.video(url))
        XCTAssertNotEqual(MediaViewerItem.video(url), MediaViewerItem.audio(url))
        XCTAssertEqual(MediaViewerItem.image(url), MediaViewerItem.image(url))
    }
}
