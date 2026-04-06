import SwiftUI

/// Fixed Aspect Ratio Grid
///
/// A grid layout component that applies a uniform aspect ratio to all items.
/// Optimized for displaying content where consistent aspect ratios are required,
/// such as photo galleries, product listings, and media libraries.
///
/// ## Features
/// - **Fixed Aspect Ratio**: Applies uniform ratio to all items
/// - **Responsive Width**: Automatically adjusts item width based on screen size
/// - **Maximum Width Control**: Prevents oversizing on large screens like iPad
/// - **Lazy Loading**: Efficient rendering based on LazyVGrid
///
/// ## Usage Examples
///
/// ### Product Listing Grid
/// ```swift
/// AspectGrid(
///     minItemWidth: 140,
///     maxItemWidth: 180,
///     itemAspectRatio: 1,  // Square
///     spacing: .md
/// ) {
///     ForEach(products) { product in
///         ProductCardView(product)
///     }
/// }
/// ```
///
/// ### Photo Gallery
/// ```swift
/// AspectGrid(
///     minItemWidth: 160,
///     maxItemWidth: 200,
///     itemAspectRatio: 3/4,  // Standard photo ratio
///     spacing: .sm
/// ) {
///     ForEach(photos) { photo in
///         PhotoView(photo)
///     }
/// }
/// ```
///
/// ### Video Thumbnail Grid
/// ```swift
/// AspectGrid(
///     minItemWidth: 200,
///     maxItemWidth: 280,
///     itemAspectRatio: 16/9,  // Standard video ratio
///     spacing: .lg
/// ) {
///     ForEach(videos) { video in
///         VideoThumbnailView(video)
///     }
/// }
/// ```
///
/// ## Design Guidelines
///
/// ### Aspect Ratio Selection
/// - **1:1 (1.0)**: Product thumbnails, profile images, icons
/// - **3:4 (0.75)**: Photos, portraits
/// - **16:9 (1.78)**: Video thumbnails, wide content
///
/// ### Item Width Settings
/// - **minItemWidth**: Minimum width for compact display (typically 80-160pt)
/// - **maxItemWidth**: Maximum width for large screens (typically 200-300pt)
///
/// ### Spacing Selection
/// - **.xs (8pt)**: Dense icon grids
/// - **.sm (12pt)**: Compact thumbnails
/// - **.md (16pt)**: Standard grid (default)
/// - **.lg (20pt)**: Spacious layouts
/// - **.xl (24pt)**: Premium content
public struct AspectGrid<Content: View>: View {
    private let minItemWidth: CGFloat
    private let maxItemWidth: CGFloat
    private let itemAspectRatio: CGFloat
    private let spacing: GridSpacing
    private let alignment: HorizontalAlignment
    private let content: () -> Content

    /// Creates a fixed aspect ratio grid
    ///
    /// - Parameters:
    ///   - minItemWidth: Minimum item width (pt)
    ///   - maxItemWidth: Maximum item width (pt)
    ///   - itemAspectRatio: Item aspect ratio (width/height)
    ///   - spacing: Spacing between grid items (default: .md)
    ///   - alignment: Horizontal alignment of items within the grid (default: .center)
    ///   - content: Content to display in the grid
    ///
    /// ## Example
    /// ```swift
    /// AspectGrid(
    ///     minItemWidth: 160,
    ///     maxItemWidth: 200,
    ///     itemAspectRatio: 2/3
    /// ) {
    ///     ForEach(items) { item in
    ///         ItemView(item)
    ///     }
    /// }
    /// ```
    public init(
        minItemWidth: CGFloat,
        maxItemWidth: CGFloat,
        itemAspectRatio: CGFloat,
        spacing: GridSpacing = .md,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.minItemWidth = minItemWidth
        self.maxItemWidth = maxItemWidth
        self.itemAspectRatio = itemAspectRatio
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }

    public var body: some View {
        LazyVGrid(
            columns: [
                GridItem(
                    .adaptive(
                        minimum: minItemWidth,
                        maximum: maxItemWidth
                    ),
                    spacing: spacing.value
                )
            ],
            alignment: alignment,
            spacing: spacing.value
        ) {
            content()
                .aspectRatio(itemAspectRatio, contentMode: .fit)
        }
    }
}

// MARK: - Previews

#Preview("Book Covers") {
    ScrollView {
        AspectGrid(
            minItemWidth: 120,
            maxItemWidth: 160,
            itemAspectRatio: 2/3,
            spacing: .md
        ) {
            ForEach(0..<12, id: \.self) { index in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue.opacity(0.3))
                    .overlay {
                        Text("\(index + 1)")
                            .font(.title)
                            .foregroundColor(.white)
                    }
            }
        }
        .padding()
    }
}

#Preview("Square Icons") {
    ScrollView {
        AspectGrid(
            minItemWidth: 60,
            maxItemWidth: 80,
            itemAspectRatio: 1,
            spacing: .xs
        ) {
            ForEach(0..<20, id: \.self) { index in
                Circle()
                    .fill(Color.green.opacity(0.3))
                    .overlay {
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                    }
            }
        }
        .padding()
    }
}

#Preview("Movie Posters") {
    ScrollView {
        AspectGrid(
            minItemWidth: 140,
            maxItemWidth: 200,
            itemAspectRatio: 3/4,
            spacing: .lg
        ) {
            ForEach(0..<8, id: \.self) { index in
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.purple.opacity(0.3))
                    .overlay {
                        VStack {
                            Image(systemName: "film")
                                .font(.largeTitle)
                            Text("Movie \(index + 1)")
                        }
                        .foregroundColor(.white)
                    }
            }
        }
        .padding()
    }
}
