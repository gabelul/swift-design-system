import DesignSpec

/// Represents the SmartHR Design System as the first real instance of `DesignSpec`.
/// Values are taken from research/misc/2026-06-11-smarthr-ground-truth.md
/// (collected from the smarthr-ui source).
///
/// The fact that this compiles and round-trips is itself proof that the schema
/// can represent SmartHR's specifics (warm grey / harmonic-type scale ramp /
/// char-relative spacing / double focus ring / system font delegation) without
/// loss. This will later be migrated to BrandSmartHR.
enum SmartHRSpecFixture {
    static let spec = DesignSpec(
        meta: BrandMeta(
            id: "smarthr",
            name: "SmartHR",
            sourceURL: "https://github.com/kufu/smarthr-ui",
            fidelityNotes: "Conforms to the real values in smarthr-ui's src/themes. Only tokens are reproduced.",
            assetPolicy: "Logo, trademarks, and dedicated typefaces are not bundled. SmartHR itself delegates to system-ui, so fonts fall back."
        ),
        theme: VisualTheme(
            atmosphere: ["warm", "trustworthy", "business", "accessible"],
            summary: "A warm-grey-based tone for a business SaaS product, foregrounding readability and accessibility through a double focus ring and generous line height."
        ),
        color: ColorSpec(
            primitives: [
                ColorToken(name: "BLACK", hex: "#030302", note: "warm black hwb(56,17,1)"),
                ColorToken(name: "WHITE", hex: "#ffffff"),
                ColorToken(name: "GREY_5", hex: "#f8f7f6", note: "warm grey"),
                ColorToken(name: "GREY_6", hex: "#f5f4f3"),
                ColorToken(name: "GREY_7", hex: "#f2f1f0"),
                ColorToken(name: "GREY_9", hex: "#edebe8"),
                ColorToken(name: "GREY_20", hex: "#d6d3d0"),
                ColorToken(name: "GREY_30", hex: "#c1bdb7"),
                ColorToken(name: "GREY_65", hex: "#706d65"),
                ColorToken(name: "GREY_100", hex: "#23221e"),
                ColorToken(name: "BLUE_100", hex: "#0077c7"),
                ColorToken(name: "BLUE_101", hex: "#0071c1"),
                ColorToken(name: "GREEN_100", hex: "#0f7f85"),
                ColorToken(name: "ORANGE_100", hex: "#f56121"),
                ColorToken(name: "RED_100", hex: "#e01e5a"),
                ColorToken(name: "YELLOW_100", hex: "#ffcc17"),
                ColorToken(name: "SMARTHR_BLUE", hex: "#00c4cc", note: "brand cyan"),
            ],
            roles: [
                ColorRole(role: "TEXT_BLACK", ref: "GREY_100"),
                ColorRole(role: "TEXT_GREY", ref: "GREY_65"),
                ColorRole(role: "TEXT_DISABLED", ref: "GREY_30"),
                ColorRole(role: "TEXT_LINK", ref: "BLUE_101"),
                ColorRole(role: "TEXT_WHITE", ref: "WHITE"),
                ColorRole(role: "MAIN", ref: "BLUE_100"),
                ColorRole(role: "OUTLINE", ref: "BLUE_100"),
                ColorRole(role: "DANGER", ref: "RED_100"),
                ColorRole(role: "WARNING_YELLOW", ref: "YELLOW_100"),
                ColorRole(role: "BRAND", ref: "SMARTHR_BLUE", note: "Distinct from MAIN (blue). Cyan taken from the logo."),
                ColorRole(role: "BACKGROUND", ref: "GREY_5"),
                ColorRole(role: "BASE_GREY", ref: "GREY_6"),
                ColorRole(role: "OVER_BACKGROUND", ref: "GREY_7"),
                ColorRole(role: "HEAD", ref: "GREY_9"),
                ColorRole(role: "BORDER", ref: "GREY_20"),
            ],
            states: [
                ColorState(name: "hover", transform: .darken(0.05)),
                ColorState(name: "disabled", transform: .alpha(0.5)),
                ColorState(name: "link-hover", transform: .darken(0.062)),
            ]
        ),
        typography: TypographySpec(
            fontStack: FontStack(
                families: [],
                system: true,
                note: "smarthr-ui delegates to system-ui, sans-serif. CJK readability is ensured via leading 1.5."
            ),
            scaleModel: .harmonic(base: 1.0, scaleFactor: 6.0),
            ramp: [
                TypeStyle(role: "XXS", sizeRem: 6.0 / 9.0, weight: .regular, leadingRef: "normal"),
                TypeStyle(role: "XS", sizeRem: 6.0 / 8.0, weight: .regular, leadingRef: "normal"),
                TypeStyle(role: "S", sizeRem: 6.0 / 7.0, weight: .regular, leadingRef: "normal"),
                TypeStyle(role: "M", sizeRem: 1.0, weight: .regular, leadingRef: "normal"),
                TypeStyle(role: "L", sizeRem: 6.0 / 5.0, weight: .bold, leadingRef: "tight"),
                TypeStyle(role: "XL", sizeRem: 6.0 / 4.0, weight: .bold, leadingRef: "tight"),
                TypeStyle(role: "XXL", sizeRem: 2.0, weight: .bold, leadingRef: "tight"),
            ],
            leading: [
                LeadingToken(name: "none", multiplier: 1.0),
                LeadingToken(name: "tight", multiplier: 1.25),
                LeadingToken(name: "normal", multiplier: 1.5),
                LeadingToken(name: "relaxed", multiplier: 1.75),
            ]
        ),
        spacing: SpacingSpec(
            model: .charRelative(basePx: 8.0),
            steps: [
                SpacingStep(name: "NONE", value: 0, multiplier: 0),
                SpacingStep(name: "X3S", value: 4, multiplier: 0.25),
                SpacingStep(name: "XXS", value: 8, multiplier: 0.5),
                SpacingStep(name: "XS", value: 16, multiplier: 1.0),
                SpacingStep(name: "S", value: 24, multiplier: 1.5),
                SpacingStep(name: "M", value: 32, multiplier: 2.0),
                SpacingStep(name: "L", value: 40, multiplier: 2.5),
                SpacingStep(name: "XL", value: 48, multiplier: 3.0),
                SpacingStep(name: "XXL", value: 56, multiplier: 3.5),
                SpacingStep(name: "X3L", value: 64, multiplier: 4.0),
            ]
        ),
        radius: RadiusSpec(steps: [
            RadiusStep(name: "s", value: 4),
            RadiusStep(name: "m", value: 6),
            RadiusStep(name: "l", value: 8),
            RadiusStep(name: "full", value: 10000),
        ]),
        elevation: ElevationSpec(
            layers: [
                ElevationLayer(name: "BASE", yOffset: 0, blur: 4, opacity: 0.15, rawCSS: "rgba(3,3,2,.15) 0 0 4px 0"),
                ElevationLayer(name: "DIALOG", yOffset: 4, blur: 10, opacity: 0.30, rawCSS: "rgba(3,3,2,.30) 0 4px 10px 0"),
                ElevationLayer(name: "LAYER1", yOffset: 1, blur: 2, opacity: 0.30, rawCSS: "0 1px 2px 0 rgba(3,3,2,.30)"),
                ElevationLayer(name: "LAYER2", yOffset: 2, blur: 4, opacity: 0.30, rawCSS: "0 2px 4px 1px rgba(3,3,2,.30)"),
            ],
            focusRing: FocusRing(doubleRing: true, colorRef: "OUTLINE", note: "0 0 0 2px white, 0 0 0 4px OUTLINE")
        ),
        layout: LayoutSpec(
            principles: ["High-density tables/forms for business use", "Spacing follows the rhythm of typography (char-relative)"],
            breakpoints: []
        ),
        components: [
            ComponentSpec(
                archetype: "FocusIndicator",
                name: "Double ring focus",
                annotation: "Guarantees focus visibility regardless of background color via a white gap + color double ring. SmartHR's fingerprint for foregrounding accessibility.",
                sourceURL: "https://github.com/kufu/smarthr-ui",
                fidelity: "Matches down to the shadow values"
            ),
            ComponentSpec(
                archetype: "FormControl",
                name: "FormControl",
                annotation: "Structures label/help/error to reduce cognitive load and mistakes in business data entry. Core suggestion for business SaaS.",
                sourceURL: "https://github.com/kufu/smarthr-ui"
            ),
        ],
        guidance: Guidance(
            dos: ["Use leading 1.5 for body text", "Keep spacing consistent with the char-relative scale", "Use a double ring for focus"],
            donts: ["Don't use pure black/pure grey (keep a warm base)", "Don't confuse MAIN (blue) with BRAND (cyan)"],
            agentPrompt: "Generate a trustworthy business SaaS UI with a warm-grey base, generous line height, and a double focus ring."
        )
    )
}
