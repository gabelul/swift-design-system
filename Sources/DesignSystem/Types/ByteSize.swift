import Foundation

/// A type representing byte sizes.
///
/// Provides an intuitive way to specify file sizes.
/// Combined with Int extension for natural syntax.
///
/// ## Usage
/// ```swift
/// // Using Int extension
/// let imageMaxSize = 1.mb
/// let videoMaxSize = 50.mb
///
/// // Using static methods
/// let size = ByteSize.megabytes(100)
///
/// // Getting byte count
/// print(size.bytes) // 104857600
///
/// // Formatted string
/// print(size.formatted) // "100 MB"
/// ```
public struct ByteSize: Sendable, Equatable, Comparable, Hashable {
    /// Number of bytes
    public let bytes: Int

    // MARK: - Initializers

    /// Initialize from byte count.
    ///
    /// - Parameter bytes: Number of bytes
    public init(bytes: Int) {
        self.bytes = bytes
    }

    // MARK: - Static Factory Methods

    /// Create from bytes.
    ///
    /// - Parameter value: Number of bytes
    /// - Returns: ByteSize
    public static func bytes(_ value: Int) -> ByteSize {
        ByteSize(bytes: value)
    }

    /// Create from kilobytes.
    ///
    /// - Parameter value: Number of kilobytes
    /// - Returns: ByteSize
    public static func kilobytes(_ value: Int) -> ByteSize {
        ByteSize(bytes: value * 1_024)
    }

    /// Create from megabytes.
    ///
    /// - Parameter value: Number of megabytes
    /// - Returns: ByteSize
    public static func megabytes(_ value: Int) -> ByteSize {
        ByteSize(bytes: value * 1_024 * 1_024)
    }

    /// Create from gigabytes.
    ///
    /// - Parameter value: Number of gigabytes
    /// - Returns: ByteSize
    public static func gigabytes(_ value: Int) -> ByteSize {
        ByteSize(bytes: value * 1_024 * 1_024 * 1_024)
    }

    // MARK: - Computed Properties

    /// Number of kilobytes (truncated).
    public var kilobytes: Int {
        bytes / 1_024
    }

    /// Number of megabytes (truncated).
    public var megabytes: Int {
        bytes / (1_024 * 1_024)
    }

    /// Number of gigabytes (truncated).
    public var gigabytes: Int {
        bytes / (1_024 * 1_024 * 1_024)
    }

    /// Formatted string.
    ///
    /// Displays using appropriate units.
    /// Examples: "1.5 MB", "500 KB", "2 GB"
    public var formatted: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useBytes, .useKB, .useMB, .useGB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(bytes))
    }

    // MARK: - Comparable

    public static func < (lhs: ByteSize, rhs: ByteSize) -> Bool {
        lhs.bytes < rhs.bytes
    }

    // MARK: - Operators

    /// Addition
    public static func + (lhs: ByteSize, rhs: ByteSize) -> ByteSize {
        ByteSize(bytes: lhs.bytes + rhs.bytes)
    }

    /// Subtraction
    public static func - (lhs: ByteSize, rhs: ByteSize) -> ByteSize {
        ByteSize(bytes: max(0, lhs.bytes - rhs.bytes))
    }

    /// Multiplication
    public static func * (lhs: ByteSize, rhs: Int) -> ByteSize {
        ByteSize(bytes: lhs.bytes * rhs)
    }

    /// Division
    public static func / (lhs: ByteSize, rhs: Int) -> ByteSize {
        ByteSize(bytes: lhs.bytes / rhs)
    }
}

// MARK: - Int Extension

public extension Int {
    /// ByteSize in bytes.
    var bytes: ByteSize {
        ByteSize.bytes(self)
    }

    /// ByteSize in kilobytes.
    var kb: ByteSize {
        ByteSize.kilobytes(self)
    }

    /// ByteSize in megabytes.
    var mb: ByteSize {
        ByteSize.megabytes(self)
    }

    /// ByteSize in gigabytes.
    var gb: ByteSize {
        ByteSize.gigabytes(self)
    }
}

// MARK: - CustomStringConvertible

extension ByteSize: CustomStringConvertible {
    public var description: String {
        formatted
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension ByteSize: ExpressibleByIntegerLiteral {
    /// Initialize from integer literal (in bytes).
    ///
    /// - Parameter value: Number of bytes
    public init(integerLiteral value: Int) {
        self.bytes = value
    }
}
