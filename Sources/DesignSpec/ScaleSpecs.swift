import Foundation

/// The spacing scale. Can express both an absolute-pt model and a char-relative
/// (em-based) model.
///
/// SmartHR is char-relative (base 8px, charSize=16px, step = multiplier x 16px).
/// This differs philosophically from the existing absolute-pt `SpacingScale`, so
/// the validity condition here is being able to hold both.
public struct SpacingSpec: Codable, Sendable, Equatable {
    public var model: SpacingModel
    public var steps: [SpacingStep]

    public init(model: SpacingModel, steps: [SpacingStep]) {
        self.model = model
        self.steps = steps
    }
}

public enum SpacingModel: Codable, Sendable, Equatable {
    /// Treat the value as pt directly
    case absolutePt
    /// Computed from a base (px) and a multiplier (conversion to pt happens in the derivation layer)
    case charRelative(basePx: Double)
}

public struct SpacingStep: Codable, Sendable, Equatable {
    public var name: String
    /// The resolved pt value (absolute), or the px value after resolving the multiplier
    public var value: Double
    /// The original char-relative multiplier (for record-keeping; may be nil)
    public var multiplier: Double?

    public init(name: String, value: Double, multiplier: Double? = nil) {
        self.name = name
        self.value = value
        self.multiplier = multiplier
    }
}

/// The corner radius scale.
public struct RadiusSpec: Codable, Sendable, Equatable {
    public var steps: [RadiusStep]

    public init(steps: [RadiusStep]) {
        self.steps = steps
    }
}

public struct RadiusStep: Codable, Sendable, Equatable {
    public var name: String
    /// pt (full uses a very large value)
    public var value: Double

    public init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
}
