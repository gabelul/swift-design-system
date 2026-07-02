import SwiftUI
import DesignSystem
import DesignSpec

/// An insight annotation. Captures the "why" behind a component/token decision and fuels
/// cross-brand comparison.
public struct DesignAnnotation: Sendable, Equatable {
    /// What problem it solves
    public var purpose: String
    /// Why it works (conversion, retention, accessibility, etc.)
    public var whyItWorks: String
    /// URL to the primary source
    public var sourceURL: String?

    public init(purpose: String, whyItWorks: String, sourceURL: String? = nil) {
        self.purpose = purpose
        self.whyItWorks = whyItWorks
        self.sourceURL = sourceURL
    }

    /// Builds an annotation from `DesignSpec`'s `ComponentSpec` (treats the spec as the source of truth).
    public init(from component: ComponentSpec) {
        self.purpose = component.name
        self.whyItWorks = component.annotation
        self.sourceURL = component.sourceURL
    }
}

/// A single showcase entry registered in the catalog. Renders a brand's signature component
/// **under that brand's own theme**, paired with an archetype (comparison axis) and an insight
/// annotation.
///
/// Lining up entries that share the same `archetype` is the heart of compare-mode
/// (e.g. viewing SmartHR's FormControl side by side with another company's FormControl).
public struct CatalogEntry: Identifiable {
    public let id: String
    /// Brand identifier (e.g. "smarthr")
    public let brandId: String
    public let brandName: String
    /// The cross-brand comparison axis (e.g. "FormControl", "FocusIndicator", "ProductCard")
    public let archetype: String
    public let title: String
    public let annotation: DesignAnnotation
    /// The brand theme this entry renders under
    public let theme: any Theme
    /// The raw component (type-erased)
    public let content: AnyView

    @MainActor
    public init<Content: View>(
        id: String,
        brandId: String,
        brandName: String,
        archetype: String,
        title: String,
        annotation: DesignAnnotation,
        theme: any Theme,
        @ViewBuilder content: @MainActor () -> Content
    ) {
        self.id = id
        self.brandId = brandId
        self.brandName = brandName
        self.archetype = archetype
        self.title = title
        self.annotation = annotation
        self.theme = theme
        self.content = AnyView(content())
    }
}

public extension Array where Element == CatalogEntry {
    /// Groups entries by archetype (for compare-mode). Sorted by archetype name.
    func groupedByArchetype() -> [(archetype: String, entries: [CatalogEntry])] {
        Dictionary(grouping: self, by: \.archetype)
            .sorted { $0.key < $1.key }
            .map { (archetype: $0.key, entries: $0.value) }
    }

    /// Only the entries matching the given archetype.
    func entries(ofArchetype archetype: String) -> [CatalogEntry] {
        filter { $0.archetype == archetype }
    }
}
