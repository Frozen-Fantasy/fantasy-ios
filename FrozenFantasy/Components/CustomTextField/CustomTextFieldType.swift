//
//  CustomTextFieldType.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import SwiftUI

extension CustomTextField {
    enum ContentType {
        case firstName,
             lastName,
             email(isNew: Bool = false),
             nickname(isNew: Bool = false),
             password(isNew: Bool = false),
             confirmPassword,
             verificationCode,
             someText,
             someInteger,
             someDecimal

        var keyboardType: UIKeyboardType {
            switch self {
            case .firstName, .lastName:
                .namePhonePad
            case .email:
                .emailAddress
            case .nickname, .password, .confirmPassword:
                .asciiCapable
            case .someText:
                .default
            case .verificationCode, .someInteger:
                .numberPad
            case .someDecimal:
                .numbersAndPunctuation
            }
        }

        var contentType: UITextContentType? {
            switch self {
            case .firstName:
                .givenName
            case .lastName:
                .familyName
            case .email:
                .emailAddress
            case .password(isNew: false):
                .password
            case .password(isNew: true), .confirmPassword:
                .newPassword
            case .verificationCode:
                .oneTimeCode
            default:
                nil
            }
        }

        var autocapitalization: TextInputAutocapitalization {
            switch self {
            case .email, .nickname, .password, .confirmPassword:
                .never
            case .someText:
                .sentences
            default:
                .words
            }
        }

        var shouldBeSecure: Bool {
            switch self {
            case .password, .confirmPassword:
                true
            default:
                false
            }
        }

        var disableAutocorrection: Bool {
            switch self {
            case .email, .nickname, .password, .confirmPassword:
                true
            default:
                false
            }
        }
    }
}
