import Foundation

/// Root model that represents a brand's design spec in a machine-readable form.
///
/// A Codable port of `awesome-design-md-jp`'s `DESIGN.md` (9 sections).
/// SwiftUI-independent, pure data — a CLI can generate, validate, diff, and import it.
/// Deriving a `Theme` (tokens) from this deterministically is the responsibility
/// of the layer above (DesignSystemCore).
///
/// Design principles:
/// - Values are platform-independent (colors are hex strings, dimensions are numbers).
/// - Validity condition: brand differences must be preserved without loss (must be able
///   to express SmartHR's char-relative spacing, its harmonic-type scale ramp, and its
///   double focus ring).
public struct DesignSpec: Codable, Sendable, Equatable {
    /// §0 Brand meta
    public var meta: BrandMeta
    /// §1 Visual Theme & Atmosphere
    public var theme: VisualTheme
    /// §2 Color Palette & Roles
    public var color: ColorSpec
    /// §3 Typography Rules (the main event for CJK extension)
    public var typography: TypographySpec
    /// §5 Layout's spacing system (char-relative / absolute)
    public var spacing: SpacingSpec
    /// Corner radius
    public var radius: RadiusSpec
    /// §6 Depth & Elevation
    public var elevation: ElevationSpec
    /// §5/§8 Layout Principles & Responsive
    public var layout: LayoutSpec
    /// §4 Component Stylings (per-archetype + suggestive annotations)
    public var components: [ComponentSpec]
    /// §7/§9 Do's & Don'ts + Agent Prompt Guide
    public var guidance: Guidance

    public init(
        meta: BrandMeta,
        theme: VisualTheme,
        color: ColorSpec,
        typography: TypographySpec,
        spacing: SpacingSpec,
        radius: RadiusSpec,
        elevation: ElevationSpec,
        layout: LayoutSpec,
        components: [ComponentSpec],
        guidance: Guidance
    ) {
        self.meta = meta
        self.theme = theme
        self.color = color
        self.typography = typography
        self.spacing = spacing
        self.radius = radius
        self.elevation = elevation
        self.layout = layout
        self.components = components
        self.guidance = guidance
    }
}

/// Brand meta. Assumes OSS publication, so it explicitly states what's distributable
/// (typefaces, logos, etc.).
public struct BrandMeta: Codable, Sendable, Equatable {
    /// Unique identifier (e.g. "smarthr")
    public var id: String
    /// Display name
    public var name: String
    /// URL of the primary source (public design system, etc.). Basis for full-fidelity claims.
    public var sourceURL: String?
    /// Notes on fidelity/reproduction (how faithful this is, what was omitted)
    public var fidelityNotes: String?
    /// Legal: declaration of assets NOT bundled (paid typefaces, logos, trademarks)
    public var assetPolicy: String?

    public init(id: String, name: String, sourceURL: String? = nil, fidelityNotes: String? = nil, assetPolicy: String? = nil) {
        self.id = id
        self.name = name
        self.sourceURL = sourceURL
        self.fidelityNotes = fidelityNotes
        self.assetPolicy = assetPolicy
    }
}

/// §1 Visual Theme & Atmosphere — a set of keywords for aesthetic direction.
public struct VisualTheme: Codable, Sendable, Equatable {
    /// Keywords describing the mood (e.g. ["warm", "trustworthy", "business", "accessible"])
    public var atmosphere: [String]
    /// One-sentence description of the direction
    public var summary: String

    public init(atmosphere: [String], summary: String) {
        self.atmosphere = atmosphere
        self.summary = summary
    }
}
