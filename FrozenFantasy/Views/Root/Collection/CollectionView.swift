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
                VStack {
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card)
                        }
                    }
                }
                .padding(16)
            }
            .animation(.default, value: viewModel.cards)
            .navigationTitle("Коллекция")
            .task {
                await viewModel.fetchCards()
            }
        }
    }
}

#Preview {
    CollectionView()
}
