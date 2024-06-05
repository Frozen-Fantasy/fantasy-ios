//
//  StatLabel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 04.06.2024.
//

import SwiftUI

struct StatLabel: View {
    let title: String
    let value: String

    init(_ title: String, value: any Numeric) {
        self.title = title
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        self.value = formatter.string(for: value) ?? "0"
    }

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
            Text(value)
                .bold()
        }
    }
}

#Preview {
    StatLabel("Stat", value: 15)
        .font(.customBody1)
}
