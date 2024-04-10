//
//  CustomButtonStyle.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 02.04.2024.
//

import Foundation
import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled

    enum Variant: CaseIterable {
        case text, bordered, filled
    }

    var variant: Variant = .filled

    private var labelColor: Color {
        switch variant {
        case .text, .bordered:
            isEnabled ? .accent : .gray
        case .filled:
            .white
        }
    }

    private var borderColor: Color {
        switch variant {
        case .filled, .bordered:
            isEnabled ? .accent : .gray
        case .text:
            .white
        }
    }

    private var fillColor: Color {
        switch variant {
        case .filled:
            isEnabled ? .accent : .gray
        case .bordered, .text:
            .white
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16))
            .foregroundStyle(labelColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 8).strokeBorder(borderColor, lineWidth: 2)
            }
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(fillColor)
            }
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

extension ButtonStyle where Self == CustomButtonStyle {
    static var custom: Self { Self() }
    static var customText: Self { Self(variant: .text) }
    static var customBordered: Self { Self(variant: .bordered) }
}

#Preview {
    VStack {
        ForEach(CustomButtonStyle.Variant.allCases, id: \.self) { variant in
            Spacer()
            
            Button {
                print("\(variant) pressed")
            } label: {
                Label("Press me!", systemImage: "star")
            }
            .buttonStyle(CustomButtonStyle(variant: variant))
            
            Button {
                print("\(variant) pressed")
            } label: {
                Label("Press me!", systemImage: "star")
            }
            .buttonStyle(CustomButtonStyle(variant: variant))
            .disabled(true)
            
            Spacer()
        }
    }
}
