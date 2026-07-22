import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public extension View {
    /// Applies a typography token.
    ///
    /// Pass a role (``Typography``) and the size, weight, line height, and font
    /// resolved by the Environment's ``TypographyScale`` are applied. A theme can
    /// swap the scale for a brand-specific ramp; with no scale installed,
    /// ``DefaultTypographyScale`` (derived from the built-in values) keeps the
    /// original look.
    ///
    /// Resolution needs an Environment read, so it is deferred to
    /// ``TypographyModifier``. Constructing the modifier is nonisolated; SwiftUI
    /// invokes its actor-isolated `body(content:)` when rendering the view.
    ///
    /// ```swift
    /// Text("Headline").typography(.headlineLarge)
    /// Text("Headline").typography(.headlineLarge, design: .serif)
    /// ```
    nonisolated func typography(_ token: Typography, design: Font.Design? = nil) -> some View {
        modifier(TypographyModifier(role: token, design: design))
    }
}

/// Internal modifier that resolves `.typography(_:)`. Reads the Environment scale
/// and the user's Dynamic Type size, then applies the resolved font at a scaled size.
private struct TypographyModifier: ViewModifier {
    let role: Typography
    let design: Font.Design?
    @Environment(\.typographyScale) private var scale
    // Reading this makes `body` re-run whenever the user changes their text size,
    // so `scaledSize` below is always current — this is what makes the ramp
    // respond to Dynamic Type (system fonts have no `.custom(relativeTo:)`
    // equivalent, so we scale the point size ourselves).
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    nonisolated init(role: Typography, design: Font.Design?) {
        self.role = role
        self.design = design
    }

    func body(content: Content) -> some View {
        let style = scale.style(for: role)
        let scaledSize = TypographyScaling.scaledSize(
            style.size,
            textStyle: style.relativeTextStyle,
            dynamicTypeSize: dynamicTypeSize
        )
        // Leading stays at the design delta rather than scaling with the point
        // size — scaling it made wrapped text at accessibility sizes far too airy,
        // and the font scaling is what actually carries legibility.
        //
        // An earlier version of this comment claimed SwiftUI doesn't measure
        // `.lineSpacing`. That is wrong: `TextMeasurementTests` shows a wrapped
        // Text does report the taller height, so the leading here is safe for
        // layout. Don't reintroduce truncation workarounds on that theory.
        return content
            .font(style.font(scaledSize: scaledSize, design: design))
            .lineSpacing(max(0, style.lineHeight - style.size))
            .tracking((style.trackingEm ?? 0) * scaledSize)
    }
}

/// Dynamic Type scaling for a base point size, keyed to a role's semantic text
/// style. Split out so it's unit-testable and has a clean non-UIKit fallback.
public enum TypographyScaling {
    /// `base` scaled for `dynamicTypeSize` using `textStyle`'s growth curve.
    /// Returns `base` unchanged at the default text size, so the default ramp is
    /// preserved; larger and accessibility sizes scale it continuously.
    public static func scaledSize(
        _ base: CGFloat,
        textStyle: Font.TextStyle,
        dynamicTypeSize: DynamicTypeSize
    ) -> CGFloat {
        #if canImport(UIKit)
        let traits = UITraitCollection(preferredContentSizeCategory: dynamicTypeSize.uiContentSizeCategory)
        return UIFontMetrics(forTextStyle: textStyle.uiTextStyle)
            .scaledValue(for: base, compatibleWith: traits)
        #else
        return base
        #endif
    }
}

#if canImport(UIKit)
extension DynamicTypeSize {
    /// The UIKit content-size category matching this SwiftUI Dynamic Type size.
    var uiContentSizeCategory: UIContentSizeCategory {
        switch self {
        case .xSmall: return .extraSmall
        case .small: return .small
        case .medium: return .medium
        case .large: return .large
        case .xLarge: return .extraLarge
        case .xxLarge: return .extraExtraLarge
        case .xxxLarge: return .extraExtraExtraLarge
        case .accessibility1: return .accessibilityMedium
        case .accessibility2: return .accessibilityLarge
        case .accessibility3: return .accessibilityExtraLarge
        case .accessibility4: return .accessibilityExtraExtraLarge
        case .accessibility5: return .accessibilityExtraExtraExtraLarge
        @unknown default: return .large
        }
    }
}

extension Font.TextStyle {
    /// The UIKit text style matching this SwiftUI text style (for UIFontMetrics).
    var uiTextStyle: UIFont.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption1
        case .caption2: return .caption2
        @unknown default: return .body
        }
    }
}
#endif
