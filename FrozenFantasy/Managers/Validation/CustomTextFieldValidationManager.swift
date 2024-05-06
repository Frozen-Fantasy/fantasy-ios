//
//  CustomTextFieldValidationManager.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import Foundation

final class CustomTextFieldValidationManager {
    static let shared = CustomTextFieldValidationManager()

    private var newPassword: String?

    private func checkRegex(_ pattern: String, for input: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            fatalError("Failed to create regex with pattern '\(pattern)'")
        }

        let range = NSRange(location: 0, length: input.utf16.count)
        let matches = regex.matches(in: input, range: range)

        return matches.count == 1 && matches.first?.range == range
    }

    func validate(_ input: String, as type: CustomTextField.ContentType) -> String? {
        getFunction(for: type)(input)
    }

    private func getFunction(for type: CustomTextField.ContentType) -> (String) -> String? {
        switch type {
        case .firstName, .lastName:
            isValidName(_:)
        case let .email(isNew): { self.isValidEmail($0, isNew: isNew) }
        case let .nickname(isNew): { self.isValidNickname($0, isNew: isNew) }
        case let .password(isNew): { self.isValidPassword($0, isNew: isNew) }
        case .confirmPassword:
            isValidConfirmPassword(_:)
        case .verificationCode:
            isValidVerificationCode(_:)
        case .someInteger:
            isValidInteger(_:)
        case .someDecimal:
            isValidDecimal(_:)
        case .someText: { _ in nil }
        }
    }

    private func isValidInteger(_ input: String) -> String? {
        if Int(input) != nil { nil } else { "Должно быть целым числом" }
    }

    private func isValidDecimal(_ input: String) -> String? {
        if Double(input) != nil { nil } else { "Должно быть числом" }
    }

    private func isValidName(_ input: String) -> String? {
        let pattern = #"[a-zA-Zа-яА-Я \-'‘’]+"#
        return checkRegex(pattern, for: input) ? nil : "Неподдерживаемый символ"
    }

    private func isValidEmail(_ input: String, isNew: Bool) -> String? {
        let pattern = #"[A-Za-z0-9._%+-]+@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,}"#
        guard checkRegex(pattern, for: input) || input.isEmpty
        else { return "Некорректный формат" }

        // TODO: Check for uniqueness
        return nil
    }

    private func isValidNickname(_ input: String, isNew: Bool) -> String? {
        let pattern = #"[a-zA-Z0-9\-_]+"#
        guard checkRegex(pattern, for: input) || input.isEmpty
        else { return "Некорректный формат" }

        // TODO: Check for uniqueness
        return nil
    }

    private func isValidPassword(_ input: String, isNew: Bool) -> String? {
        let characterPattern = #"[a-zA-Z0-9`'‘’".,:;!?@#$%^&*()\[\]\{\}<>\-+=_\\\/]+"#
        guard checkRegex(characterPattern, for: input)
        else { return "Неподдерживаемый символ" }

        guard input.count >= 8
        else { return "Не меньше 8 символов" }

        let uppercasePattern = #".*[A-Z]+.*"#
        guard checkRegex(uppercasePattern, for: input)
        else { return "Как минимум 1 заглавная буква" }

        let digitPattern = #".*[0-9]+.*"#
        guard checkRegex(digitPattern, for: input)
        else { return "Как минимум 1 цифра" }

        let specialCharacterPattern = #".*[`'‘’".,:;!?@#$%^&*()\[\]\{\}<>\-_+=\\\/]+.*"#
        guard checkRegex(specialCharacterPattern, for: input)
        else { return "Как минимум 1 специальный символ" }

        if isNew {
            newPassword = input
        }
        return nil
    }

    private func isValidConfirmPassword(_ input: String) -> String? {
        return input == newPassword ? nil : "Пароли не совпадают"
    }

    private func isValidVerificationCode(_ input: String) -> String? {
        if let error = isValidInteger(input) {
            return error
        }

        return input.count == 6 ? nil : "Некорректный формат"
    }
}
