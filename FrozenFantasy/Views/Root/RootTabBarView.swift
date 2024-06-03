//
//  RootTabBarView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct RootTabBarView: View {
    @EnvironmentObject private var appState: AppState

    private enum Tab {
        case tournaments,
             teams,
             rating,
             collection,
             profile
    }

    @State private var currentTab: Tab = .tournaments

    init() {
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: "Exo2-SemiBold", size: 13)!],
            for: .normal)

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .init(.customGray)
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.customGray)]

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Exo2-Bold", size: 32)!]
        UINavigationBar.appearance().titleTextAttributes = [.font: UIFont(name: "Exo2-SemiBold", size: 20)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: "Exo2-Regular", size: 18)!],
            for: .normal)
    }

    var body: some View {
        TabView(selection: $currentTab) {
            TournamentsView()
                .tag(Tab.tournaments)
                .tabItem {
                    Image("icon:trophy")
                        .renderingMode(.template)
                    Text("Турниры")
                }

            TeamsView()
                .tag(Tab.teams)
                .tabItem {
                    Image("icon:team")
                        .renderingMode(.template)
                    Text("Команды")
                }

            StoreView()
                .tag(Tab.rating)
                .tabItem {
                    Image("icon:store")
                        .renderingMode(.template)
                    Text("Магазин")
                }

            CollectionView()
                .tag(Tab.collection)
                .tabItem {
                    Image("icon:cards")
                        .renderingMode(.template)
                    Text("Коллекция")
                }

            ProfileView()
                .tag(Tab.profile)
                .tabItem {
                    Image("icon:account")
                        .renderingMode(.template)
                    Text("Профиль")
                }
        }
    }
}

#Preview {
    RootTabBarView()
        .environmentObject(AppState())
}
