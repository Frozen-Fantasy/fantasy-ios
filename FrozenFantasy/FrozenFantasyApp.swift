//
//  FrozenFantasyApp.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.03.2024.
//

import SDWebImage
import SDWebImageSVGCoder
import SwiftUI

@MainActor final class AppState: ObservableObject {
    static let shared = AppState()

    enum Screen {
        case login, registration, main
    }

    @Published private(set) var currentScreen: Screen = .login

    @Published fileprivate var alertMessage: String = ""
    @Published fileprivate var presentingAlert: Bool = false

    init() {
        currentScreen = TokenManager.shared.hasValidToken ? .main : .login
    }

    func setCurrentScreen(to screen: Screen) async {
        currentScreen = screen
    }

    func presentAlert(message: String) async {
        alertMessage = message
        presentingAlert = true
    }
}

@main
struct FrozenFantasyApp: App {
    @StateObject private var appState = AppState.shared

    init() {
        setupDependencies()
    }

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
            .animation(.default.speed(2), value: appState.currentScreen == .main)
            .alert("Что-то пошло не так...", isPresented: $appState.presentingAlert) {} message: {
                Text(appState.alertMessage)
            }
        }
    }
}

extension FrozenFantasyApp {
    func setupDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)

        let cache = SDImageCache()
        SDImageCachesManager.shared.addCache(cache)
        SDWebImageManager.defaultImageCache = SDImageCachesManager.shared
    }
}
