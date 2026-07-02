import SwiftUI
import DesignSystem

/// Renders a single entry **under that brand's own theme**.
/// A SmartHR entry renders with the SmartHR theme (warm colors, wide line spacing).
public struct ThemedEntryView: View {
    private let entry: CatalogEntry
    @State private var provider: ThemeProvider

    public init(_ entry: CatalogEntry) {
        self.entry = entry
        _provider = State(initialValue: ThemeProvider(initialTheme: entry.theme))
    }

    public var body: some View {
        entry.content
            .theme(provider)
    }
}

/// An annotated entry card (component render + the "why").
public struct CatalogEntryCard: View {
    private let entry: CatalogEntry
    public init(_ entry: CatalogEntry) { self.entry = entry }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(entry.title).font(.headline)
                Spacer()
                Text(entry.brandName).font(.caption).foregroundStyle(.secondary)
            }
            ThemedEntryView(entry)
                .padding(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.06)))

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.annotation.purpose).font(.caption).bold()
                Text(entry.annotation.whyItWorks).font(.caption).foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .frame(maxWidth: 360, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2)))
    }
}

/// Gallery: lists every entry, grouped by archetype and stacked vertically.
public struct CatalogGalleryView: View {
    private let entries: [CatalogEntry]
    public init(_ entries: [CatalogEntry]) { self.entries = entries }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(entries.groupedByArchetype(), id: \.archetype) { group in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(group.archetype).font(.title3).bold()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 16) {
                                ForEach(group.entries) { CatalogEntryCard($0) }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

/// Compare-mode: pick one archetype and compare every brand's implementation side by side
/// (the heart of the insight feature).
public struct CatalogCompareView: View {
    private let archetype: String
    private let entries: [CatalogEntry]

    public init(archetype: String, in entries: [CatalogEntry]) {
        self.archetype = archetype
        self.entries = entries.entries(ofArchetype: archetype)
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Compare · \(archetype)").font(.title3).bold()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(entries) { CatalogEntryCard($0) }
                }
            }
        }
        .padding()
    }
}
