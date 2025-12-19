import SwiftUI

/// Light theme color palette
public struct LightColorPalette: ColorPalette {
    public init() {}

    // MARK: - Primary
    public var primary: Color { PrimitiveColors.blue500 }
    public var onPrimary: Color { .white }

    // MARK: - Secondary
    public var secondary: Color { PrimitiveColors.purple500 }
    public var onSecondary: Color { .white }

    // MARK: - Tertiary
    public var tertiary: Color { PrimitiveColors.cyan500 }
    public var onTertiary: Color { .white }

    // MARK: - Background & Surface
    public var background: Color { .white }
    public var onBackground: Color { PrimitiveColors.gray900 }
    public var surface: Color { PrimitiveColors.gray50 }
    public var onSurface: Color { PrimitiveColors.gray900 }
    public var surfaceVariant: Color { PrimitiveColors.gray100 }
    public var onSurfaceVariant: Color { PrimitiveColors.gray700 }

    // MARK: - Semantic State
    public var error: Color { PrimitiveColors.red500 }
    public var warning: Color { PrimitiveColors.orange500 }
    public var success: Color { PrimitiveColors.green500 }
    public var info: Color { PrimitiveColors.blue500 }

    // MARK: - Outline
    public var outline: Color { PrimitiveColors.gray300 }

    // Container colors use default implementation from protocol extension
}
