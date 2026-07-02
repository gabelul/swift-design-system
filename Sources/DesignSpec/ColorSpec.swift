import Foundation

/// §2 Color Palette & Roles.
///
/// Two-tier structure: primitive (raw color ladder) -> role (semantic meaning).
/// State (hover/disabled etc.) holds "functions" as values, so a brand's derivation
/// rules (e.g. SmartHR's hover = darken 5%, disabled = alpha 0.5) aren't lost.
public struct ColorSpec: Codable, Sendable, Equatable {
    /// Raw color tokens (kept as an array to preserve name order)
    public var primitives: [ColorToken]
    /// Semantic roles (reference a primitive name or a hex value)
    public var roles: [ColorRole]
    /// State derivation rules (hover / disabled / link-hover etc.)
    public var states: [ColorState]

    public init(primitives: [ColorToken], roles: [ColorRole], states: [ColorState] = []) {
        self.primitives = primitives
        self.roles = roles
        self.states = states
    }

    /// Look up a primitive by name (helper for role resolution).
    public func primitive(named name: String) -> ColorToken? {
        primitives.first { $0.name == name }
    }
}

/// A raw color token.
public struct ColorToken: Codable, Sendable, Equatable {
    public var name: String
    /// `#rrggbb` or `#rrggbbaa`
    public var hex: String
    /// Provenance note (e.g. "warm black hwb(56,17,1)")
    public var note: String?

    public init(name: String, hex: String, note: String? = nil) {
        self.name = name
        self.hex = hex
        self.note = note
    }
}

/// A semantic role. `ref` is a primitive name (preferred) or a direct hex value.
public struct ColorRole: Codable, Sendable, Equatable {
    /// Role name (e.g. "MAIN", "TEXT_LINK", "BRAND"). Kept verbatim from the brand's vocabulary.
    public var role: String
    /// The primitive name it references, or `#hex`
    public var ref: String
    public var note: String?

    public init(role: String, ref: String, note: String? = nil) {
        self.role = role
        self.ref = ref
        self.note = note
    }
}

/// A state derivation rule.
public struct ColorState: Codable, Sendable, Equatable {
    public var name: String
    public var transform: ColorTransform

    public init(name: String, transform: ColorTransform) {
        self.name = name
        self.transform = transform
    }
}

/// A color transform function. Holds a brand's derivation logic declaratively.
public enum ColorTransform: Codable, Sendable, Equatable {
    /// Darken (0.0-1.0)
    case darken(Double)
    /// Lighten (0.0-1.0)
    case lighten(Double)
    /// Multiply opacity (0.0-1.0)
    case alpha(Double)
    /// Free-form description for rules that don't fit the cases above
    case custom(String)
}
