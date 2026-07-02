import Foundation

/// §3 Typography Rules (the core of the CJK expansion).
///
/// Holds everything the old fixed `Typography` enum couldn't express:
/// - CJK font stacks (specified-but-not-bundled = system delegation is first-class too)
/// - Separation of size and leading (line-height multiplier) (SmartHR: 16px body x 1.5 leading)
/// - Records the generation model (e.g. SmartHR's harmonic ramp) without losing it
public struct TypographySpec: Codable, Sendable, Equatable {
    public var fontStack: FontStack
    /// Ramp generation model (basis for inference and reproduction)
    public var scaleModel: ScaleModel
    /// Per-role type styles
    public var ramp: [TypeStyle]
    /// Leading tokens (multipliers). Roles reference these by name.
    public var leading: [LeadingToken]

    public init(fontStack: FontStack, scaleModel: ScaleModel, ramp: [TypeStyle], leading: [LeadingToken]) {
        self.fontStack = fontStack
        self.scaleModel = scaleModel
        self.ramp = ramp
        self.leading = leading
    }

    public func leading(named name: String) -> LeadingToken? {
        leading.first { $0.name == name }
    }
}

/// Font stack. When `system == true`, no bundled typeface is used and the host's
/// system font takes over (this is SmartHR's actual practice, and the default policy
/// that structurally sidesteps typeface licensing issues).
public struct FontStack: Codable, Sendable, Equatable {
    /// Family names in priority order (CJK -> Latin -> generic). Can be empty when `system` is true.
    public var families: [String]
    /// Whether this delegates to system-ui
    public var system: Bool
    public var note: String?

    public init(families: [String] = [], system: Bool = true, note: String? = nil) {
        self.families = families
        self.system = system
        self.note = note
    }
}

/// Generation model for the type ramp.
public enum ScaleModel: Codable, Sendable, Equatable {
    /// Harmonic series (size = base * scaleFactor/(scaleFactor+diff)). SmartHR's approach.
    case harmonic(base: Double, scaleFactor: Double)
    /// Geometric (size = base * ratio^step). Major Third, etc.
    case modular(base: Double, ratio: Double)
    /// Manually specified
    case manual
}

/// Per-role type style. Size is stored in rem (1rem = 16px baseline) to stay platform-independent.
public struct TypeStyle: Codable, Sendable, Equatable {
    /// Role name (e.g. "body-m", "heading-l"). Preserves the brand's own vocabulary.
    public var role: String
    /// rem (1rem = 16px)
    public var sizeRem: Double
    public var weight: FontWeightToken
    /// Reference to a leading token name (e.g. "normal")
    public var leadingRef: String
    /// Letter spacing (em). Usually nil/0 for CJK text.
    public var trackingEm: Double?

    public init(role: String, sizeRem: Double, weight: FontWeightToken, leadingRef: String, trackingEm: Double? = nil) {
        self.role = role
        self.sizeRem = sizeRem
        self.weight = weight
        self.leadingRef = leadingRef
        self.trackingEm = trackingEm
    }
}

public enum FontWeightToken: String, Codable, Sendable, Equatable {
    case thin, light, regular, medium, semibold, bold, heavy, black
}

/// Leading token (multiplier). E.g. normal = 1.5.
public struct LeadingToken: Codable, Sendable, Equatable {
    public var name: String
    public var multiplier: Double

    public init(name: String, multiplier: Double) {
        self.name = name
        self.multiplier = multiplier
    }
}
