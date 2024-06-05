//
//  CollectionView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject private var userStore: UserStore
    @StateObject private var viewModel = CollectionViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 12),
                                    GridItem(.flexible(), spacing: 12)],
                          spacing: 12) {
                    ForEach($viewModel.cards) { $card in
                        CollectionCardView($card) { id in
                            await viewModel.unpackCard(id: id)
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Коллекция")
            .animation(.default, value: viewModel.cards)
            .task {
                guard AppState.shared.currentScreen == .main
                else { return }

                await viewModel.fetchCards(userID: userStore.user?.id)
                await userStore.fetchUserInfo()
            }
            .refreshable {
                await viewModel.fetchCards(userID: userStore.user?.id)
                await userStore.fetchUserInfo()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CoinLabel(userStore.user?.coins ?? 0)
                }
            }
        }
    }
}

#Preview {
    CollectionView()
}
