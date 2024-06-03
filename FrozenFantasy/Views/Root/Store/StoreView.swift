//
//  StoreView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct StoreView: View {
    @StateObject var viewModel = StoreViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(),
                                    GridItem()]) {
                    ForEach(viewModel.cardPacks) { cardPack in
                        CardPackView(cardPack) { id in
                            await viewModel.buyCardPack(id: id)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Магазин")
            .animation(.default, value: viewModel.cardPacks)
            .task {
                await viewModel.fetchCardPacks()
            }
            .refreshable {
                await viewModel.fetchCardPacks()
            }
            .alert("Покупка успешна!", isPresented: $viewModel.presentingSuccess) {} message: {
                Text("Новые карточки добавлены в Коллекцию.")
            }
        }
    }
}

#Preview {
    StoreView()
}
