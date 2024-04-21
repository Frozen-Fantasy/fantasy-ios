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

    @Published private(set) var currentScreen: Screen = .login

    func setScreenTo(_ screen: Screen) {
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
                    Text("Registration View Placeholder")
                case .main:
                    Text("Main View Placeholder")
                }
            }
            .transition(.slide)
            .animation(.easeInOut, value: appState.currentScreen)
            .environmentObject(appState)
        }
    }
}
