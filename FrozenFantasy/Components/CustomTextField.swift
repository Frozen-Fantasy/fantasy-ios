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
    var placeholder: String
    var tip: String

    var isSecure: Bool

    @FocusState var isFocused: Bool
    @Environment(\.isEnabled) var isEnabled

    init(_ placeholder: String = "", text: Binding<String>, tip: String = "", isSecure: Bool = false) {
        self.placeholder = placeholder
        self._text = text
        self.tip = tip
        self.isSecure = isSecure
    }
    
    private var isLabelShifted: Bool {
        !text.isEmpty || isFocused
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(" ")
                .font(.customBody2)
                .opacity(0)

            ZStack(alignment: .leading) {
                Text(placeholder)
                    .font(isLabelShifted ? .customBody2 : .customBody1)
                    .foregroundStyle(isFocused ? .customBlue : .customBlack)
                    .offset(y: isLabelShifted ? -20 : 0)
                ZStack {
                    if isSecure {
                        SecureField("", text: $text)
                    } else {
                        TextField("", text: $text)
                    }
                }
                .focused($isFocused)
                .font(.customBody1)
                .foregroundStyle(isEnabled ? .customBlack : .customGray)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(isFocused ? .customBlue : .customBlack)
            Text(tip)
                .font(.customCaption2)
                .foregroundStyle(.customGray)
                .opacity(isFocused ? 1 : 0)
        }
        .animation(.default.speed(1.5), value: text)
        .animation(.default.speed(3), value: isFocused)
    }
}

struct CustomTextFieldPreviewContainer: View {
    @State var username: String = ""

    var body: some View {
        VStack {
            CustomTextField("Username", text: $username, tip: "Only letters and numbers")
                .padding()
        }
    }
}

#Preview {
    CustomTextFieldPreviewContainer()
}
