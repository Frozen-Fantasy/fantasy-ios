//
//  ColorExtension.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 10.04.2024.
//

import Foundation
import SwiftUI

public extension Color {
    init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0)
    }

    init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}

public extension Color {
    static let customBlack = Color(hex: 0x2D2D2D)
    static let customGray = Color(hex: 0xAEAEAE)

    static let customBlue = Color(hex: 0x186FB6)
    static let customOrange = Color(hex: 0xFD6735)
    static let customGreen = Color(hex: 0x84BF56)
    static let customRed = Color(hex: 0xEC4034)
}

#Preview {
    VStack {
        Text("Text")
            .foregroundStyle(Color.customBlack)
        Text("Caption")
            .foregroundStyle(Color.customGray)
        
        Text("Blue")
            .foregroundStyle(Color.customBlue)
        Text("Orange")
            .foregroundStyle(Color.customOrange)
        Text("Green")
            .foregroundStyle(Color.customGreen)
        Text("Red")
            .foregroundStyle(Color.customRed)
    }
    .font(.largeTitle)
}
