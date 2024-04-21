//
//  CustomTextField.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 10.04.2024.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    // MARK: Properties

    @Binding private var text: String
    private var contentType: ContentType
    private var placeholder: String
    private var tip: String
    private var isRequired: Bool

    init(_ contentType: ContentType, text: Binding<String>, placeholder: String = "", tip: String = "      ", required: Bool = false) {
        self.contentType = contentType
        self._text = text
        self.placeholder = placeholder
        self.tip = tip
        self.isRequired = required
    }

    // MARK: State

    @State private var wasInteractedWith: Bool = false
    @FocusState private var isFocused: Bool
    @Environment(\.isEnabled) private var isEnabled

    /// Is the placeholder label shifted
    private var isLabelShifted: Bool {
        !text.isEmpty || isFocused
    }

    /// Color of the label and divider
    private var foregroundColor: Color {
        if !isEnabled {
            .customGray
        } else if !isValid {
            .customRed
        } else if isFocused {
            .customBlue
        } else {
            .customBlack
        }
    }

    // MARK: Validation

    /// Binding to external variable
    @Environment(\.validationBinding) private var validationBinding

    /// Error message after validation, `nil` of no errors
    @State private var errorMessage: String? {
        didSet { validationBinding?.wrappedValue = errorMessage == nil }
    }

    /// Is textfield in error state or not
    private var isValid: Bool {
        errorMessage == nil || !wasInteractedWith
    }

    private let validationManager = CustomTextFieldValidationManager.shared
    private func validate() {
        if isRequired, text.isEmpty {
            errorMessage = "Обязательное поле"
        } else if !isRequired, text.isEmpty {
            errorMessage = nil
        } else if let error = validationManager.validate(text, as: contentType) {
            errorMessage = error
        } else {
            errorMessage = nil
        }
    }

    // MARK: Body

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            // Reserve for placeholderLabel
            Text(" ")
                .font(.customBody2)
                .opacity(0)

            ZStack(alignment: .leading) {
                // Animated placeholder label
                Text(placeholder)
                    .font(isLabelShifted ? .customBody2 : .customBody1)
                    .foregroundStyle(foregroundColor)
                    .offset(y: isLabelShifted ? -20 : 0)

                // Textfields
                ZStack {
                    if contentType.shouldBeSecure {
                        SecureField("", text: $text)
                            .onTapGesture { wasInteractedWith = true }
                    } else {
                        TextField("", text: $text) { _ in wasInteractedWith = true }
                    }
                }
                .frame(height: 20)
                .font(.customBody1)
                .foregroundStyle(isEnabled ? .customBlack : .customGray)

                .textContentType(contentType.contentType)
                .keyboardType(contentType.keyboardType)
                .textInputAutocapitalization(contentType.autocapitalization)
                .autocorrectionDisabled(contentType.disableAutocorrection)

                .focused($isFocused)
            }

            // Divider
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(foregroundColor)

            // Tip
            Text(errorMessage ?? tip)
                .id((errorMessage ?? tip).hashValue)
                .font(.customCaption2)
                .foregroundStyle(isValid ? .customGray : .customRed)
                .opacity(!isValid || isFocused ? 1 : 0)
        }
        .onAppear { validate() }
        .onChange(of: text) { _ in validate() }
        .animation(.default.speed(2), value: isFocused)
        .animation(.default.speed(2), value: isValid)
    }
}

private struct CustomTextFieldPreviewContainer: View {
    @State var username: String = ""
    @State var usernameIsValid: Bool = true

    var body: some View {
        HStack {
            CustomTextField(.email, text: $username, placeholder: "Почта", required: false)
                .bindValidation(to: $usernameIsValid)
            Text(usernameIsValid ? "✅" : "❌")
        }
        .padding()
    }
}

#Preview {
    CustomTextFieldPreviewContainer()
}
