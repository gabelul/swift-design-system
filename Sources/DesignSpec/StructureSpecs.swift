import Foundation

/// §6 Depth & Elevation.
///
/// Fully porting shadow CSS across platforms isn't realistic, so this keeps both
/// structured fields and the provenance record (rawCSS) side by side as the basis
/// for fidelity claims.
/// The focus ring is an accessibility fingerprint (SmartHR uses a white gap + color
/// double ring), so it gets first-class treatment.
public struct ElevationSpec: Codable, Sendable, Equatable {
    public var layers: [ElevationLayer]
    public var focusRing: FocusRing?

    public init(layers: [ElevationLayer], focusRing: FocusRing? = nil) {
        self.layers = layers
        self.focusRing = focusRing
    }
}

public struct ElevationLayer: Codable, Sendable, Equatable {
    public var name: String
    /// Shadow's y offset (pt, approximate)
    public var yOffset: Double?
    /// Blur radius (pt, approximate)
    public var blur: Double?
    /// Opacity (0-1, approximate)
    public var opacity: Double?
    /// Original raw CSS (basis for full-fidelity claims)
    public var rawCSS: String?

    public init(name: String, yOffset: Double? = nil, blur: Double? = nil, opacity: Double? = nil, rawCSS: String? = nil) {
        self.name = name
        self.yOffset = yOffset
        self.blur = blur
        self.opacity = opacity
        self.rawCSS = rawCSS
    }
}

public struct FocusRing: Codable, Sendable, Equatable {
    /// Whether it's a double ring (white gap + color)
    public var doubleRing: Bool
    /// Ring color (role name or hex)
    public var colorRef: String
    public var note: String?

    public init(doubleRing: Bool, colorRef: String, note: String? = nil) {
        self.doubleRing = doubleRing
        self.colorRef = colorRef
        self.note = note
    }
}

/// §5 Layout Principles + §8 Responsive.
public struct LayoutSpec: Codable, Sendable, Equatable {
    public var principles: [String]
    public var breakpoints: [Breakpoint]

    public init(principles: [String] = [], breakpoints: [Breakpoint] = []) {
        self.principles = principles
        self.breakpoints = breakpoints
    }
}

public struct Breakpoint: Codable, Sendable, Equatable {
    public var name: String
    public var minWidth: Double

    public init(name: String, minWidth: Double) {
        self.name = name
        self.minWidth = minWidth
    }
}

/// §4 Component Stylings.
///
/// Doesn't constrain via a behavioral protocol — **standardizes metadata only**
/// (the brand's own shape is what's suggestive). `archetype` enables cross-brand
/// comparison, and `annotation` (why it was built this way) fuels the suggestion layer.
public struct ComponentSpec: Codable, Sendable, Equatable {
    /// Axis for cross-brand comparison (e.g. "ProductCard", "FocusIndicator", "FormControl")
    public var archetype: String
    /// The name used within the brand (e.g. "FormControl")
    public var name: String
    /// Suggestive annotation: why this design / what problem it solves / how it affects
    /// conversion or retention
    public var annotation: String
    /// URL of the primary source
    public var sourceURL: String?
    /// Fidelity note
    public var fidelity: String?

    public init(archetype: String, name: String, annotation: String, sourceURL: String? = nil, fidelity: String? = nil) {
        self.archetype = archetype
        self.name = name
        self.annotation = annotation
        self.sourceURL = sourceURL
        self.fidelity = fidelity
    }
}

/// §7 Do's & Don'ts + §9 Agent Prompt Guide.
public struct Guidance: Codable, Sendable, Equatable {
    public var dos: [String]
    public var donts: [String]
    /// Prompt guidance for getting an AI to generate a consistent UI
    public var agentPrompt: String?

    public init(dos: [String] = [], donts: [String] = [], agentPrompt: String? = nil) {
        self.dos = dos
        self.donts = donts
        self.agentPrompt = agentPrompt
    }
}
