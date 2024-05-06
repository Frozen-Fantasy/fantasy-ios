//
//  ProfileView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerView

                    TransactionsView(transactions: viewModel.transactions)
                }
                .padding()
            }
            .navigationTitle("Профиль")

            // MARK: Animation

            .animation(.default, value: viewModel.user)
            .animation(.default, value: viewModel.transactions)

            // MARK: Fetch actions

            .task {
                await viewModel.fetchUserInfo()
                await viewModel.fetchTransactions()
            }
            .refreshable {
                await viewModel.fetchUserInfo()
                await viewModel.fetchTransactions()
            }

            // MARK: Alerts

            .alert(isPresented: $viewModel.presentingLogoutAlert) {
                Alert(
                    title: Text("Подтвердите действие"),
                    message: Text("Вы уверены, что хотите выйти из аккаунта?"),
                    primaryButton: .destructive(Text("Выйти")) {
                        viewModel.logout()
                        appState.setScreen(to: .login)
                    },
                    secondaryButton: .cancel()
                )
            }
            .alert("Что-то пошло не так...", isPresented: $viewModel.presentingAlert) {} message: {
                Text(viewModel.alertMessage)
            }

            // MARK: Toolbar

            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button {
                        viewModel.presentingLogoutAlert = true
                    } label: {
                        Image("icon:logout")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.customRed)
                            .frame(height: 24)
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 4) {
                        Text("\(viewModel.user.coins)")
                            .font(.customBody1)
                            .bold()
                            .foregroundStyle(.customBlack)
                        Image("icon:coins")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.customYellow)
                    }
                    .fixedSize()
                }
            }
        }
    }

    private var headerView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 32) {
                AsyncImage(url: viewModel.user.photo) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
                .frame(width: 80, height: 80)

                VStack(alignment: .leading, spacing: 4) {
                    Text("\(viewModel.user.nickname)")
                        .font(.customTitle2)
                    Text("\(viewModel.user.email)")
                        .font(.customBody1)
                }
                .foregroundStyle(.customBlack)
                .lineLimit(1)

                Spacer()
            }

            Text("На сервисе с \(viewModel.user.registrationDate.simpleDateString)")
                .font(.customBody1)
                .foregroundStyle(.customGray)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
