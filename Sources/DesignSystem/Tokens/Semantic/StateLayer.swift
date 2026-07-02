import SwiftUI

/// State-layer opacity tokens. Represents the strength of the foreground-color overlay applied
/// during interactions like hover/pressed/focus (equivalent to Material's state layer).
///
/// State representation varies by brand (SmartHR uses hover=darken 5% + an INPUT_HOVER ring,
/// Material uses overlay opacity). We standardize on the opacity-overlay model here.
public protocol StateLayer: Sendable {
    var hover: Double { get }
    var focus: Double { get }
    var pressed: Double { get }
    var dragged: Double { get }
    var selected: Double { get }
}

public struct DefaultStateLayer: StateLayer {
    public init() {}
    public var hover: Double { 0.08 }
    public var focus: Double { 0.10 }
    public var pressed: Double { 0.10 }
    public var dragged: Double { 0.16 }
    public var selected: Double { 0.12 }
}
