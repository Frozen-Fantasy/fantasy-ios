//
//  CustomTextField.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 10.04.2024.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String = ""
    var tip: String = ""

    var isSecure: Bool = false

    @FocusState var isFocused: Bool
    @Environment(\.isEnabled) var isEnabled

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ZStack(alignment: .leading) {
                Text(placeholder)
                    .font(.customBodyMedium)
                    .foregroundStyle(isFocused ? .customBlue : .customBlack)
                    .offset(y: text.isEmpty ? 0 : -21)
                Group {
                    if isSecure {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .focused($isFocused)
                .font(.customBody)
                .foregroundStyle(isEnabled ? .customBlack : .customGray)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(isFocused ? .customBlue : .customBlack)
            Text(tip)
                .font(.customCaption)
                .foregroundStyle(.customGray)
                .opacity(isFocused ? 1 : 0)
        }
        .animation(.default.speed(1.5), value: text)
        .animation(.default.speed(3), value: isFocused)
    }
}

struct CustomTextFieldPreviewContainer: View {
    @State var email: String = ""

    var body: some View {
        CustomTextField(text: $email, placeholder: "Username", tip: "Only letters and numbers")
            .padding()
    }
}

#Preview {
    CustomTextFieldPreviewContainer()
}
