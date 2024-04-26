//
//  RootTabBarView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct RootTabBarView: View {
    @EnvironmentObject private var appState: AppState
    
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
    }
    
    var body: some View {
        TabView(selection: $appState.currentTab) {
            TournamentsView()
                .tag(AppState.Tab.tournaments)
                .tabItem {
                    Image("icon:trophy")
                        .renderingMode(.template)
                    Text("Турниры")
                }
            
            TeamsView()
                .tag(AppState.Tab.teams)
                .tabItem {
                    Image("icon:team")
                        .renderingMode(.template)
                    Text("Команды")
                }
            
            RatingsView()
                .tag(AppState.Tab.rating)
                .tabItem {
                    Image("icon:ratings")
                        .renderingMode(.template)
                    Text("Рейтинг")
                }
            
            CollectionView()
                .tag(AppState.Tab.collection)
                .tabItem {
                    Image("icon:cards")
                        .renderingMode(.template)
                    Text("Коллекция")
                }
            
            ProfileView()
                .tag(AppState.Tab.profile)
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
