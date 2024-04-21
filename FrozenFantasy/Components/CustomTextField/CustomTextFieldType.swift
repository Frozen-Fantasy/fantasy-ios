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
             email,
             password,
             newPassword,
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
            case .password, .newPassword, .confirmPassword:
                .asciiCapable
            case .verificationCode:
                .numberPad
            case .someText:
                .default
            case .someInteger:
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
            case .password:
                .password
            case .newPassword, .confirmPassword:
                .newPassword
            case .verificationCode:
                .oneTimeCode
            default:
                nil
            }
        }
        
        var autocapitalization: TextInputAutocapitalization {
            switch self {
            case .email, .password, .newPassword, .confirmPassword:
                .never
            case .someText:
                .sentences
            default:
                .words
            }
        }
        
        var shouldBeSecure: Bool {
            switch self {
            case .password, .newPassword, .confirmPassword:
                true
            default:
                false
            }
        }
        
        var disableAutocorrection: Bool {
            switch self {
            case .email, .password, .newPassword, .confirmPassword:
                true
            default:
                false
            }
        }
    }
}
