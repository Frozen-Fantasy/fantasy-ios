//
//  FrozenFantasyApp.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.03.2024.
//

import SwiftUI

@MainActor final class AppState: ObservableObject {
    enum Screen {
        case login, registration, main
    }
    
    enum Tab {
        case tournaments,
             teams,
             rating,
             collection,
             profile
    }

    @Published private(set) var currentScreen: Screen = .main
    @Published var currentTab: Tab = .tournaments
    
    init() {
        currentScreen = TokenManager.shared.isTokenValid() ? .main : .login
    }

    func setScreen(to screen: Screen) {
        withAnimation {
            currentScreen = screen
        }
    }
}

@main
struct FrozenFantasyApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appState.currentScreen {
                case .login:
                    LoginView()
                case .registration:
                    RegistrationView()
                case .main:
                    RootTabBarView()
                }
            }
            .transition(.slide)
            .animation(.easeInOut, value: appState.currentScreen)
            .environmentObject(appState)
        }
    }
}
