//
//  CollectionView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct CollectionView: View {
    @StateObject private var viewModel = CollectionViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 12),
                                    GridItem(.flexible(), spacing: 12)],
                          spacing: 12) {
                    ForEach(viewModel.cards) { card in
                        CollectionCardView(card: card)
                    }
                }
                .padding(16)
            }
            .animation(.default, value: viewModel.cards)
            .navigationTitle("Коллекция")
            .task {
                guard AppState.shared.currentScreen == .main
                else { return }

                await viewModel.fetchCards()
            }
            .refreshable {
                await viewModel.fetchCards()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    CoinLabel(viewModel.coins)
                }
            }
        }
    }
}

#Preview {
    CollectionView()
}
