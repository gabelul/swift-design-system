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
        // ローカル file URL も受理する（Markdown のローカル画像対応）
        let fileURL = URL(fileURLWithPath: "/tmp/sample.png")
        let item = MediaViewerItem.image(fileURL)

        XCTAssertEqual(item.url, fileURL)
        XCTAssertTrue(item.url.isFileURL)
    }

    func testHashableDistinguishesCases() {
        let url = URL(string: "https://example.com/media")!

        // 同じ URL でも種別が違えば別アイテム
        XCTAssertNotEqual(MediaViewerItem.image(url), MediaViewerItem.video(url))
        XCTAssertNotEqual(MediaViewerItem.video(url), MediaViewerItem.audio(url))
        XCTAssertEqual(MediaViewerItem.image(url), MediaViewerItem.image(url))
    }
}
