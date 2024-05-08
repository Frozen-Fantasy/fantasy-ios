//
//  LoginView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import SwiftUI

struct LoginView: View {
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

            VStack(spacing: 4) {
                CustomTextField(.email(),
                                text: $viewModel.email,
                                placeholder: "Почта",
                                required: true)
                    .bindValidation(to: $viewModel.isEmailValid)
                CustomTextField(.password(),
                                text: $viewModel.password,
                                placeholder: "Пароль",
                                required: true)
                    .bindValidation(to: $viewModel.isPasswordValid)
            }

            VStack(spacing: 8) {
                Text(viewModel.errorMessage)
                    .font(.customBody1)
                    .foregroundStyle(.customRed)

                Button("Войти") {
                    Task { await viewModel.login() }
                }
                .buttonStyle(.custom)
                .disabled(!viewModel.isValid)
            }

            Spacer()

            VStack(spacing: 0) {
                Text("У вас еще нет аккаунта?")
                    .font(.customCaption1)
                    .foregroundColor(.customGray)

                Button {
                    Task { await viewModel.routeToRegistration() }
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
        .animation(.default, value: viewModel.isValid)
    }
}

#Preview {
    LoginView()
}
