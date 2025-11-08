# DesignSystem

SwiftUI向けの型安全で拡張可能なデザインシステム

![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS%2017.0+%20%7C%20macOS%2014.0+-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

📚 **[完全なドキュメント](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/)**

## 特徴

```swift
// テーマの適用
ContentView()
    .theme(themeProvider)

// カラーパレット
@Environment(\.colorPalette) var colors
Text("Hello").foregroundColor(colors.primary)

// スペーシング
@Environment(\.spacingScale) var spacing
VStack(spacing: spacing.lg) { /* ... */ }

// タイポグラフィ
Text("見出し").typography(.headlineLarge)
```

- **3層トークンシステム** - Primitive → Semantic → Component の明確な階層
- **型安全** - プロトコルベース設計により拡張性が高い
- **テーマ対応** - Light/Dark/カスタムテーマを簡単に切り替え
- **すぐ使える** - ボタン、カード、テキストフィールドなどの基本コンポーネント
- **ドキュメント完備** - 全てのパブリックAPIに実践的なコード例

## インストール

```swift
// Package.swift
dependencies: [
    .package(url: "https://github.com/no-problem-dev/swift-design-system.git", from: "1.0.0")
]
```

または Xcode: File > Add Package Dependencies > URL入力

## 基本的な使い方

### 1. テーマのセットアップ

```swift
@main
struct MyApp: App {
    @State private var themeProvider = ThemeProvider()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .theme(themeProvider)
        }
    }
}
```

### 2. デザイントークンの使用

#### カラーパレット

```swift
struct MyView: View {
    @Environment(\.colorPalette) var colors

    var body: some View {
        VStack {
            Text("見出し")
                .foregroundColor(colors.primary)
            Text("本文")
                .foregroundColor(colors.onSurface)
        }
        .background(colors.surface)
    }
}
```

#### スペーシングとレイアウト

```swift
struct MyView: View {
    @Environment(\.spacingScale) var spacing

    var body: some View {
        VStack(spacing: spacing.lg) {  // 16pt
            Text("項目1")
            Text("項目2")
        }
        .padding(spacing.xl)  // 24pt
    }
}
```

#### タイポグラフィ

```swift
Text("大見出し")
    .typography(.headlineLarge)

Text("本文")
    .typography(.bodyMedium)

Text("ラベル")
    .typography(.labelSmall)
```

### 3. コンポーネントの使用

#### ボタン

```swift
Button("保存") { save() }
    .buttonStyle(.primary)
    .buttonSize(.large)

Button("キャンセル") { cancel() }
    .buttonStyle(.secondary)
    .buttonSize(.medium)

Button("削除") { delete() }
    .buttonStyle(.tertiary)
```

#### カード

```swift
Card(elevation: .level2) {
    VStack(alignment: .leading, spacing: spacing.md) {
        Text("カードタイトル")
            .typography(.titleMedium)
        Text("カードの内容")
            .typography(.bodyMedium)
    }
}
```

#### セクションカード

```swift
ScrollView {
    VStack(spacing: spacing.xl) {
        SectionCard(title: "基本設定") {
            // コンテンツ
        }

        SectionCard(title: "プロフィール", elevation: .level2) {
            // コンテンツ
        }
    }
}
```

### 4. カスタムテーマの作成

```swift
// カスタムカラーパレット
struct MyBrandPalette: ColorPalette {
    var primary: Color { Color(hex: "#007AFF") }
    var onPrimary: Color { .white }
    var secondary: Color { Color(hex: "#5856D6") }
    var onSecondary: Color { .white }
    // その他の色を定義...
}

// カスタムスペーシング
struct CompactSpacingScale: SpacingScale {
    var lg: CGFloat { PrimitiveSpacing.space12 }  // デフォルトより小さく
    var xl: CGFloat { PrimitiveSpacing.space16 }
    // その他のスケールを定義...
}

// テーマに適用
themeProvider.applyCustomTheme(
    colors: MyBrandPalette(),
    spacing: CompactSpacingScale()
)
```

### 5. テーマの動的切り替え

```swift
struct SettingsView: View {
    @Environment(ThemeProvider.self) private var themeProvider

    var body: some View {
        VStack {
            Button("ライトテーマ") {
                themeProvider.switchToLight()
            }

            Button("ダークテーマ") {
                themeProvider.switchToDark()
            }

            Button("システムに従う") {
                themeProvider.followSystem()
            }
        }
    }
}
```

## アーキテクチャ

### 3層トークンシステム

```
Primitive Tokens (基本値)
    ↓ 参照
Semantic Tokens (意味的なトークン)
    ↓ 参照
Component Tokens (コンポーネント固有の値)
```

#### 1. Primitive Tokens

生の値を定義（色のHEXコード、スペーシングのpt値など）。**直接使用は避けてください。**

```swift
PrimitiveColors.blue500  // ❌ 直接使用しない
PrimitiveSpacing.space16 // ❌ 直接使用しない
```

#### 2. Semantic Tokens

意味のあるトークン（primary, surface, onSurfaceなど）をプロトコルで定義。

```swift
@Environment(\.colorPalette) var colors  // ✅
@Environment(\.spacingScale) var spacing // ✅
```

#### 3. Component Tokens

コンポーネント固有の値（ButtonSize, Elevationなど）。

```swift
.buttonSize(.large)    // ✅
Card(elevation: .level2) { ... }  // ✅
```

## API リファレンス

### Tokens

#### Semantic Tokens
- `ColorPalette` - カラーパレットプロトコル
- `SpacingScale` - スペーシングスケールプロトコル
- `RadiusScale` - 角丸スケールプロトコル
- `Typography` - タイポグラフィトークン

#### Component Tokens
- `ButtonSize` - ボタンサイズバリアント
- `Elevation` - 影のレベル定義

#### Primitive Tokens (内部使用)
- `PrimitiveColors` - 基本的な色パレット
- `PrimitiveSpacing` - 基本的なスペーシング値
- `PrimitiveRadius` - 基本的な角丸値

### Theme System

- `ThemeProvider` - テーマ管理クラス
- `LightColorPalette` / `DarkColorPalette` - デフォルトパレット
- `DefaultSpacingScale` / `DefaultRadiusScale` - デフォルトスケール

### Components

- Button Styles: `PrimaryButtonStyle`, `SecondaryButtonStyle`, `TertiaryButtonStyle`, `TextButtonStyle`
- `Card` - 汎用カードコンポーネント
- `IconButton` - アイコンボタン
- `FloatingActionButton` - フローティングアクションボタン
- `DSTextField` - デザインシステム対応テキストフィールド

### Layout Patterns

- `SectionCard` - タイトル付きカードセクション

### View Modifiers

- `.theme(_:)` - テーマ適用
- `.buttonSize(_:)` - ボタンサイズ指定
- `.typography(_:)` - タイポグラフィ適用

## 使用例

詳細な使用例は[完全なドキュメント](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/)を参照してください。

### ログイン画面

```swift
struct LoginView: View {
    @Environment(\.colorPalette) var colors
    @Environment(\.spacingScale) var spacing
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: spacing.xl) {
            Text("ログイン")
                .typography(.headlineLarge)
                .foregroundColor(colors.onBackground)

            VStack(spacing: spacing.md) {
                DSTextField(
                    text: $email,
                    placeholder: "メールアドレス",
                    keyboardType: .emailAddress
                )

                DSTextField(
                    text: $password,
                    placeholder: "パスワード",
                    isSecure: true
                )
            }

            Button("ログイン") { login() }
                .buttonStyle(.primary)
                .buttonSize(.large)

            Button("パスワードを忘れた場合") { resetPassword() }
                .buttonStyle(.text)
        }
        .padding(spacing.xl)
        .background(colors.background)
    }
}
```

### 設定画面

```swift
struct SettingsView: View {
    @Environment(\.spacingScale) var spacing

    var body: some View {
        ScrollView {
            VStack(spacing: spacing.xl) {
                SectionCard(title: "アカウント") {
                    VStack(spacing: spacing.md) {
                        SettingRow(title: "プロフィール編集", icon: "person")
                        SettingRow(title: "通知設定", icon: "bell")
                    }
                }

                SectionCard(title: "一般") {
                    VStack(spacing: spacing.md) {
                        SettingRow(title: "言語", icon: "globe")
                        SettingRow(title: "テーマ", icon: "paintbrush")
                    }
                }
            }
            .padding(.vertical, spacing.xl)
        }
    }
}
```

## 要件

- iOS 17.0+ / macOS 14.0+
- Swift 6.0+
- Xcode 16.0+

## ライセンス

MIT License - 詳細は [LICENSE](LICENSE) を参照

## サポート

- 📚 [完全なドキュメント](https://no-problem-dev.github.io/swift-design-system/documentation/designsystem/)
- 🐛 [Issue報告](https://github.com/no-problem-dev/swift-design-system/issues)
- 💬 [ディスカッション](https://github.com/no-problem-dev/swift-design-system/discussions)

---

Made with ❤️ by [NOPROBLEM](https://github.com/no-problem-dev)
