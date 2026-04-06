import Foundation

/// Component types
enum ComponentType: String, CaseIterable, Identifiable {
    case accordion = "Accordion"
    case avatar = "Avatar"
    case badge = "Badge"
    case button = "Button"
    case card = "Card"
    case chip = "Chip"
    case colorPicker = "ColorPicker"
    case emojiPicker = "EmojiPicker"
    case fab = "FloatingActionButton"
    case iconBadge = "IconBadge"
    case iconButton = "IconButton"
    case iconPicker = "IconPicker"
    case imagePicker = "ImagePicker"
    case progressBar = "ProgressBar"
    case searchField = "SearchField"
    case secureField = "SecureField"
    case skeleton = "Skeleton"
    case snackbar = "Snackbar"
    case statDisplay = "StatDisplay"
    case statusBanner = "StatusBanner"
    case textField = "TextField"
    case videoPicker = "VideoPicker"
    case videoPlayer = "VideoPlayer"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .accordion: return "chevron.down.circle.fill"
        case .avatar: return "person.circle.fill"
        case .badge: return "app.badge.fill"
        case .button: return "hand.tap.fill"
        case .card: return "rectangle.fill"
        case .chip: return "tag.fill"
        case .colorPicker: return "paintpalette.fill"
        case .emojiPicker: return "face.smiling"
        case .fab: return "plus.circle.fill"
        case .iconBadge: return "circle.fill"
        case .iconButton: return "heart.circle.fill"
        case .iconPicker: return "square.grid.3x3"
        case .imagePicker: return "photo.on.rectangle.angled"
        case .progressBar: return "chart.bar.fill"
        case .searchField: return "magnifyingglass"
        case .secureField: return "lock.fill"
        case .skeleton: return "rectangle.dashed"
        case .snackbar: return "message.fill"
        case .statDisplay: return "number.circle.fill"
        case .statusBanner: return "exclamationmark.bubble.fill"
        case .textField: return "textformat.abc"
        case .videoPicker: return "video.badge.plus"
        case .videoPlayer: return "play.rectangle.fill"
        }
    }

    var description: String {
        switch self {
        case .accordion: return "Expandable/collapsible content section"
        case .avatar: return "Circular image with initials fallback"
        case .badge: return "Notification dot or count indicator"
        case .button: return "3 types: Primary, Secondary, Tertiary"
        case .card: return "Container for grouping related information"
        case .chip: return "Compact labels for status, categories, filters"
        case .colorPicker: return "Select colors from preset palette"
        case .emojiPicker: return "Select emojis by category"
        case .fab: return "Primary action button on screen"
        case .iconBadge: return "Badge displaying icon on circular background"
        case .iconButton: return "Compact button with icon only"
        case .iconPicker: return "Select SF Symbols icons"
        case .imagePicker: return "Select images from camera and photo library"
        case .progressBar: return "Bar for visualizing progress"
        case .searchField: return "Search input with clear and cancel buttons"
        case .secureField: return "Password input with reveal toggle"
        case .skeleton: return "Shimmer placeholder for loading states"
        case .snackbar: return "Display temporary notifications and feedback"
        case .statDisplay: return "Statistics component displaying numbers and units"
        case .statusBanner: return "Inline status messages and alerts"
        case .textField: return "Text input field"
        case .videoPicker: return "Select videos from camera and video library"
        case .videoPlayer: return "Play videos from data or URL"
        }
    }
}
