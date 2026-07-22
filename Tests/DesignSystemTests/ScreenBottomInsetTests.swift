import XCTest
@testable import DesignSystem

#if os(iOS)
import SwiftUI
import UIKit

@MainActor
final class ScreenBottomInsetTests: XCTestCase {
    func testScrollScreenLaysOutPinnedFooterBelowOwnedScrollView() {
        let footerHeight: CGFloat = 72
        let pinnedHost = UIHostingController(
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
        let plainHost = UIHostingController(
            rootView: NavigationStack {
                Screen("Plain Screen") {
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

        let pinnedWindow = prepareWindow(for: pinnedHost)
        let plainWindow = prepareWindow(for: plainHost)
        RunLoop.main.run(until: Date().addingTimeInterval(0.1))

        guard let pinnedScrollView = findScrollView(in: pinnedHost.view),
              let plainScrollView = findScrollView(in: plainHost.view) else {
            XCTFail("Expected both Screen variants to install a UIScrollView")
            return
        }

        XCTAssertGreaterThanOrEqual(
            plainScrollView.bounds.height - pinnedScrollView.bounds.height,
            footerHeight,
            "The pinned footer should consume layout space below the scroll viewport."
        )
        XCTAssertLessThan(
            pinnedScrollView.adjustedContentInset.bottom,
            footerHeight,
            "Screen should not implement its footer by mutating the scroll view's safe-area inset."
        )

        _ = pinnedWindow
        _ = plainWindow
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

    private func prepareWindow(for host: UIViewController) -> UIWindow {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
        window.rootViewController = host
        window.makeKeyAndVisible()
        host.view.frame = window.bounds
        host.view.setNeedsLayout()
        host.view.layoutIfNeeded()
        window.layoutIfNeeded()
        return window
    }
}
#endif
