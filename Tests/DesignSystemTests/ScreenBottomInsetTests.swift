import XCTest
@testable import DesignSystem

#if os(iOS)
import SwiftUI
import UIKit

@MainActor
final class ScreenBottomInsetTests: XCTestCase {
    func testScrollScreenAppliesPinnedFooterToOwnedScrollView() {
        let footerHeight: CGFloat = 72
        let host = UIHostingController(
            rootView: NavigationStack {
                Screen("Pinned Footer", bottomInset: {
                    Button("Pinned CTA") {}
                        .buttonStyle(.primary)
                        .buttonSize(.large)
                        .frame(maxWidth: .infinity)
                        .frame(height: footerHeight)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white)
                }) {
                    VStack(spacing: 12) {
                        ForEach(0..<40, id: \.self) { index in
                            Text("Row \(index)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .theme(ThemeProvider())
        )

        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
        window.rootViewController = host
        window.makeKeyAndVisible()
        host.view.frame = window.bounds
        host.view.setNeedsLayout()
        host.view.layoutIfNeeded()
        window.layoutIfNeeded()
        RunLoop.main.run(until: Date().addingTimeInterval(0.1))

        guard let scrollView = findScrollView(in: host.view) else {
            XCTFail("Expected Screen to install a UIScrollView when scrollBehavior is .scrolls")
            return
        }

        XCTAssertGreaterThanOrEqual(
            scrollView.adjustedContentInset.bottom,
            footerHeight + 20,
            "Pinned footer should reserve visible scroll space above the CTA."
        )
    }

    private func findScrollView(in view: UIView) -> UIScrollView? {
        if let scrollView = view as? UIScrollView {
            return scrollView
        }

        for subview in view.subviews {
            if let scrollView = findScrollView(in: subview) {
                return scrollView
            }
        }

        return nil
    }
}
#endif
