import Foundation

/// Component types
enum ComponentType: String, CaseIterable, Identifiable {
    case button = "Button"
    case card = "Card"
    case chip = "Chip"
    case colorPicker = "ColorPicker"
    case emojiPicker = "EmojiPicker"
    case fab = "FloatingActionButton"
    case iconButton = "IconButton"
    case iconPicker = "IconPicker"
    case imagePicker = "ImagePicker"
    case snackbar = "Snackbar"
    case textField = "TextField"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .button: return "hand.tap.fill"
        case .card: return "rectangle.fill"
        case .chip: return "tag.fill"
        case .colorPicker: return "paintpalette.fill"
        case .emojiPicker: return "face.smiling"
        case .fab: return "plus.circle.fill"
        case .iconButton: return "heart.circle.fill"
        case .iconPicker: return "square.grid.3x3"
        case .imagePicker: return "photo.on.rectangle.angled"
        case .snackbar: return "message.fill"
        case .textField: return "textformat.abc"
        }
    }

    var description: String {
        switch self {
        case .button: return "Three variants: Primary, Secondary, Tertiary."
        case .card: return "Container for grouping related content."
        case .chip: return "Compact label for statuses, categories, and filters."
        case .colorPicker: return "Select colors from a preset palette."
        case .emojiPicker: return "Select emojis grouped by category."
        case .fab: return "Primary action button on the screen."
        case .iconButton: return "Compact button containing only an icon."
        case .iconPicker: return "Picker for SF Symbols icons."
        case .imagePicker: return "Select images from the camera or photo library."
        case .snackbar: return "Temporary notifications and feedback."
        case .textField: return "Text input fields."
        }
    }
}
