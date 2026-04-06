import SwiftUI

// MARK: - Chip Style Modifier

public extension View {
    /// Sets the style for the Chip
    ///
    /// ## Usage Example
    /// ```swift
    /// Chip("Label")
    ///     .chipStyle(.filled)
    ///
    /// Chip("Filter", isSelected: $isSelected)
    ///     .chipStyle(.outlined)
    ///
    /// Chip("Premium")
    ///     .chipStyle(.liquidGlass)
    /// ```
    ///
    /// - Parameter style: The ChipStyle to apply
    /// - Returns: View with the style applied
    func chipStyle<S: ChipStyle>(_ style: S) -> some View {
        environment(\.chipStyle, AnyChipStyle(style))
    }
}

// MARK: - Chip Size Modifier

public extension View {
    /// Sets the size for the Chip
    ///
    /// ## Usage Example
    /// ```swift
    /// Chip("Small Chip")
    ///     .chipSize(.small)
    ///
    /// Chip("Medium Chip")
    ///     .chipSize(.medium)
    /// ```
    ///
    /// - Parameter size: The ChipSize to apply
    /// - Returns: View with the size applied
    func chipSize(_ size: ChipSize) -> some View {
        environment(\.chipSize, size)
    }
}
