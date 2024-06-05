//
//  StoreView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct StoreView: View {
    @EnvironmentObject private var userStore: UserStore
    @StateObject var viewModel = StoreViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(),
                                    GridItem()]) {
                    ForEach(viewModel.cardPacks) { cardPack in
                        CardPackView(cardPack) { id in
                            await viewModel.buyCardPack(id: id)
                            userStore.user?.coins -= cardPack.price
                        }
                        .disabled(cardPack.price > userStore.user?.coins ?? 0)
                    }
                }
                .padding()
            }
            .navigationTitle("Магазин")
            .animation(.default, value: viewModel.cardPacks)
            .task {
                await viewModel.fetchCardPacks()
                await userStore.fetchUserInfo()
            }
            .refreshable {
                await viewModel.fetchCardPacks()
                await userStore.fetchUserInfo()
            }
            .alert("Покупка успешна!", isPresented: $viewModel.presentingSuccess) {} message: {
                Text("Новые карточки добавлены в Коллекцию.")
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
    StoreView()
}
