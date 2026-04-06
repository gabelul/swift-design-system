import SwiftUI

/// Color item.
///
/// Represents an individual color shown in the color picker.
public struct ColorItem: Identifiable, Sendable, Hashable {
    public let id: String
    public let hex: String
    public let name: String

    public init(hex: String, name: String) {
        self.id = hex
        self.hex = hex
        self.name = name
    }
}

/// Color preset.
///
/// Collection of preset colors used by the color picker.
///
/// ## Example
/// ```swift
/// struct MyView: View {
///     @State private var selectedColor: String?
///     @State private var showColorPicker = false
///
///     var body: some View {
///         Button("Select Color") {
///             showColorPicker = true
///         }
///         .colorPicker(
///             preset: .tagFriendly,
///             selectedColor: $selectedColor,
///             isPresented: $showColorPicker
///         )
///     }
/// }
/// ```
public struct ColorPreset: Identifiable, Sendable {
    public let id: String
    public let colors: [ColorItem]

    public init(id: String, colors: [ColorItem]) {
        self.id = id
        self.colors = colors
    }

    /// Color set suitable for tags and categories.
    ///
    /// Contains 10 highly distinguishable colors.
    public static var tagFriendly: ColorPreset {
        ColorPreset(id: "tagFriendly", colors: [
            ColorItem(hex: "#EF4444", name: "Red"),
            ColorItem(hex: "#F97316", name: "Orange"),
            ColorItem(hex: "#EAB308", name: "Yellow"),
            ColorItem(hex: "#10B981", name: "Green"),
            ColorItem(hex: "#14B8A6", name: "Teal"),
            ColorItem(hex: "#06B6D4", name: "Cyan"),
            ColorItem(hex: "#3B82F6", name: "Blue"),
            ColorItem(hex: "#6366F1", name: "Indigo"),
            ColorItem(hex: "#A855F7", name: "Purple"),
            ColorItem(hex: "#EC4899", name: "Pink"),
        ])
    }

    /// All primitive colors at the 500 level.
    ///
    /// Use when you want to provide more choices.
    public static var allPrimitives: ColorPreset {
        ColorPreset(id: "allPrimitives", colors: [
            ColorItem(hex: "#6B7280", name: "Gray"),
            ColorItem(hex: "#EF4444", name: "Red"),
            ColorItem(hex: "#F97316", name: "Orange"),
            ColorItem(hex: "#EAB308", name: "Yellow"),
            ColorItem(hex: "#10B981", name: "Green"),
            ColorItem(hex: "#14B8A6", name: "Teal"),
            ColorItem(hex: "#06B6D4", name: "Cyan"),
            ColorItem(hex: "#3B82F6", name: "Blue"),
            ColorItem(hex: "#6366F1", name: "Indigo"),
            ColorItem(hex: "#A855F7", name: "Purple"),
            ColorItem(hex: "#EC4899", name: "Pink"),
        ])
    }
}
