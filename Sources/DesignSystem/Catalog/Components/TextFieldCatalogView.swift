import SwiftUI

/// TextField component catalog view
struct TextFieldCatalogView: View {
    @Environment(\.colorPalette) private var colors
    @Environment(\.spacingScale) private var spacing
    @Environment(\.radiusScale) private var radius
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var search = ""
    @State private var message = ""

    var body: some View {
<<<<<<< HEAD
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Overview
                Text("Text fields are components for capturing user text input.")
                    .typography(.bodyMedium)
                    .foregroundStyle(colorPalette.onSurfaceVariant)
                    .padding(.horizontal, spacing.lg)
                    .padding(.top, spacing.lg)

                // Style variations
                SectionCard(title: "Style Variations") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Two styles are available.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.lg) {
                            DSTextField(
                                "Outlined",
                                text: $email,
                                placeholder: "Email address",
                                style: .outlined
                            )

                            DSTextField(
                                "Filled",
                                text: $password,
                                placeholder: "Password",
                                style: .filled
                            )
                        }
                    }
                }

                // With icons
                SectionCard(title: "With Icons") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Place icons at the leading or trailing edge.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(spacing: spacing.lg) {
                            DSTextField(
                                "Leading Icon",
                                text: $email,
                                placeholder: "example@email.com",
                                style: .outlined,
                                leadingIcon: "envelope"
                            )

                            DSTextField(
                                "Trailing Icon",
                                text: $search,
                                placeholder: "Search",
                                style: .outlined,
                                trailingIcon: "magnifyingglass"
                            )

                            DSTextField(
                                "Both Icons",
                                text: $password,
                                placeholder: "Password",
                                style: .outlined,
                                leadingIcon: "lock",
                                trailingIcon: "eye"
                            )
                        }
                    }
                }

                // Supporting text
                SectionCard(title: "Supporting Text") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Show additional helper information below the field.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        DSTextField(
                            "Username",
                            text: $username,
                            placeholder: "Enter username",
                            style: .outlined,
                            supportingText: "Please enter 3–20 characters."
                        )
                    }
                }

                // Error state
                SectionCard(title: "Error State") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Display validation errors.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        DSTextField(
                            "Email",
                            text: $email,
                            placeholder: "example@email.com",
                            style: .outlined,
                            error: "The email address format is invalid.",
                            leadingIcon: "envelope"
                        )
                    }
                }

                // Multiline text
                SectionCard(title: "Multiline Text") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("For longer text input.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Message")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurface.opacity(0.7))

                            TextEditor(text: $message)
                                .typography(.bodyLarge)
                                .scrollContentBackground(.hidden)
                                .frame(height: 100)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(colorPalette.surfaceVariant.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(colorPalette.outline, lineWidth: 1)
                                )

                            Text("Please enter a message.")
                                .typography(.bodySmall)
                                .foregroundStyle(colorPalette.onSurfaceVariant)
                        }
                    }
                }

                // Usage
                SectionCard(title: "Usage") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to use in SwiftUI")
                            .typography(.titleSmall)

                        Text("""
                        @State private var email = ""

                        DSTextField(
                            "Email",
                            text: $email,
                            placeholder: "example@email.com",
                            style: .outlined,
                            leadingIcon: "envelope"
                        )
                        """)
                        .typography(.bodySmall)
                        .fontDesign(.monospaced)
                        .padding()
                        .background(colorPalette.surfaceVariant.opacity(0.5))
                        .cornerRadius(8)
                    }
                }

                // Form example
                SectionCard(title: "Form Example") {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Example usage in a real form.")
                            .typography(.bodySmall)
                            .foregroundStyle(colorPalette.onSurfaceVariant)

                        Card {
                            VStack(spacing: spacing.lg) {
                                Text("Account Registration")
                                    .typography(.titleLarge)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                DSTextField(
                                    "Email",
                                    text: $email,
                                    placeholder: "example@email.com",
                                    style: .outlined,
                                    leadingIcon: "envelope"
                                )

                                DSTextField(
                                    "Password",
                                    text: $password,
                                    placeholder: "Password",
                                    style: .outlined,
                                    supportingText: "Enter at least 8 characters.",
                                    leadingIcon: "lock"
                                )

                                DSTextField(
                                    "Username",
                                    text: $username,
                                    placeholder: "Username",
                                    style: .outlined,
                                    leadingIcon: "person"
                                )

                                Button("登録") {}
                                    .buttonStyle(.primary)
                                    .buttonSize(.large)
                            }
                        }
=======
        CatalogPageContainer(title: "TextField") {
            CatalogOverview(description: "ユーザーからテキスト入力を受け取るコンポーネント")

            SectionCard(title: "スタイル") {
                VariantShowcase(title: "スタイルバリエーション", description: "2つのスタイルが利用可能") {
                    VStack(spacing: spacing.lg) {
                        DSTextField("Outlined", text: $email, placeholder: "メールアドレス", style: .outlined)
                        DSTextField("Filled", text: $password, placeholder: "パスワード", style: .filled)
                    }
                }
            }

            SectionCard(title: "アイコン") {
                VariantShowcase(title: "アイコン付き", description: "先頭または末尾にアイコンを配置") {
                    VStack(spacing: spacing.lg) {
                        DSTextField("Leading", text: $email, placeholder: "example@email.com", style: .outlined, leadingIcon: "envelope")
                        DSTextField("Trailing", text: $search, placeholder: "検索", style: .outlined, trailingIcon: "magnifyingglass")
                        DSTextField("Both", text: $password, placeholder: "パスワード", style: .outlined, leadingIcon: "lock", trailingIcon: "eye")
                    }
                }
            }

            SectionCard(title: "サポートテキスト") {
                DSTextField("ユーザー名", text: $username, placeholder: "ユーザー名を入力", style: .outlined, supportingText: "3文字以上20文字以内")
            }

            SectionCard(title: "エラー状態") {
                DSTextField("メールアドレス", text: $email, placeholder: "example@email.com", style: .outlined, error: "形式が正しくありません", leadingIcon: "envelope")
            }

            SectionCard(title: "複数行") {
                VStack(alignment: .leading, spacing: spacing.xs) {
                    Text("メッセージ")
                        .typography(.bodySmall)
                        .foregroundStyle(colors.onSurface.opacity(0.7))

                    TextEditor(text: $message)
                        .typography(.bodyLarge)
                        .scrollContentBackground(.hidden)
                        .frame(height: 100)
                        .padding(.horizontal, spacing.md)
                        .padding(.vertical, spacing.sm)
                        .background(colors.surfaceVariant.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: radius.xs))
                        .overlay(RoundedRectangle(cornerRadius: radius.xs).stroke(colors.outline, lineWidth: 1))
                }
            }

            SectionCard(title: "使用例") {
                CodeExample(code: """
                    DSTextField(
                        "メールアドレス",
                        text: $email,
                        placeholder: "example@email.com",
                        style: .outlined,
                        leadingIcon: "envelope"
                    )
                    """)
            }

            SectionCard(title: "フォーム例") {
                Card {
                    VStack(spacing: spacing.lg) {
                        Text("アカウント登録")
                            .typography(.titleLarge)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        DSTextField("メールアドレス", text: $email, placeholder: "example@email.com", style: .outlined, leadingIcon: "envelope")
                        DSTextField("パスワード", text: $password, placeholder: "パスワード", style: .outlined, supportingText: "8文字以上", leadingIcon: "lock")
                        DSTextField("ユーザー名", text: $username, placeholder: "ユーザー名", style: .outlined, leadingIcon: "person")

                        Button("登録") {}
                            .buttonStyle(.primary)
                            .buttonSize(.large)
>>>>>>> upstream/main
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TextFieldCatalogView()
            .theme(ThemeProvider())
    }
}
