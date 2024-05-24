//
//  TabBarModifier.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 24.05.2024.
//

import SwiftUI
import SwiftUIIntrospect

extension View {
    @ViewBuilder
    func isTabBarVisible(_ visibility: Bool) -> some View {
        if #available(iOS 16, *) {
            self.toolbar(visibility ? .visible : .hidden, for: .tabBar)
        } else {
            self.introspect(.tabView, on: .iOS(.v15)) { tabView in
                tabView.tabBar.isHidden = visibility
            }
        }
    }
}
