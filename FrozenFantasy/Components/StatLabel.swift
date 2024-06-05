//
//  StatLabel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 04.06.2024.
//

import SwiftUI

protocol FormattableNumeric: Numeric {
    func formatted() -> String
}

extension Int: FormattableNumeric {}
extension Double: FormattableNumeric {}

struct StatLabel: View {
    let title: String
    let value: any FormattableNumeric

    init(_ title: String, value: any FormattableNumeric) {
        self.title = title
        self.value = value
    }

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
            Text(value.formatted())
                .bold()
        }
    }
}

#Preview {
    StatLabel("Stat", value: 15)
        .font(.customBody1)
}
