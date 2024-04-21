//
//  FontExtension.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 10.04.2024.
//

import Foundation
import SwiftUI

extension Font {
    static let customTitle1: Font = .custom("Exo2-Bold", fixedSize: 24)
    static let customTitle2: Font = .custom("Exo2-Bold", fixedSize: 22)
    static let customTitle3: Font = .custom("Exo2-Bold", fixedSize: 20)
    static let customTitle4: Font = .custom("Exo2-Bold", fixedSize: 18)

    static let customBody: Font = .custom("Exo2-Regular", fixedSize: 16)
    static let customBodyMedium: Font = .custom("Exo2-Bold", fixedSize: 16)

    static let customButton: Font = .custom("Exo2-Medium", fixedSize: 16)
    
    static let customCaption1: Font = .custom("Exo2-SemiBold", fixedSize: 14)
    static let customCaption2: Font = .custom("Exo2-SemiBold", fixedSize: 12)
}

#Preview {
    Text("Hello There!")
        .font(.customBody)
}
