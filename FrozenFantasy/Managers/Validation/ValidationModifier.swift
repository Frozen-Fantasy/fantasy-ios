//
//  ValidationModifier.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import Foundation
import SwiftUI

private struct ValidationBindingKey: EnvironmentKey {
    static let defaultValue: Binding<Bool>? = nil
}

extension EnvironmentValues {
    var validationBinding: Binding<Bool>? {
        get { self[ValidationBindingKey.self] }
        set { self[ValidationBindingKey.self] = newValue }
    }
}

extension View {
    func bindValidation(to isValid: Binding<Bool>? = nil) -> some View {
        self
            .environment(\.validationBinding, isValid)
    }
}
