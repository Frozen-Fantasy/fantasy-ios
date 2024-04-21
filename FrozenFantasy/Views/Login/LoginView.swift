//
//  LoginView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appState: AppState

    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Image("applogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                Text("Авторизация")
                    .font(.customTitle1)
            }

            VStack(spacing: 0) {
                CustomTextField("Почта", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)

                CustomTextField("Пароль", text: $viewModel.password, isSecure: true)
            }

            VStack(spacing: 8) {
                Text(viewModel.errorMessage)
                    .font(.customBody1)
                    .foregroundStyle(.customRed)

                Button("Войти") {
                    Task { @MainActor in
                        if await viewModel.login() {
                            appState.setScreenTo(.main)
                        }
                    }
                }
                .buttonStyle(.custom)
            }

            Spacer()

            VStack(spacing: 0) {
                Text("У вас еще нет аккаунта?")
                    .font(.customCaption1)
                    .foregroundColor(.customGray)

                Button {
                    appState.setScreenTo(.registration)
                } label: {
                    Text("Зарегистрироваться")
                        .underline()
                        .font(.customCaption1)
                        .foregroundColor(.customGray)
                }
            }
        }
        .padding()
        .animation(.default, value: viewModel.errorMessage)
        .alert("Что-то пошло не так...", isPresented: $viewModel.presentingAlert) {} message: {
            Text(viewModel.alertMessage)
        }
    }
}

#Preview {
    LoginView()
}
