//
//  LoginView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 21.04.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    enum FocusedField {
        case email,
             password
    }

    @FocusState private var currentFocus: FocusedField?

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
                    .onSubmit {
                        currentFocus = .password
                    }
                    .bindValidation(to: $viewModel.isEmailValid)
                    .focused($currentFocus, equals: .email)
                CustomTextField(.password(),
                                text: $viewModel.password,
                                placeholder: "Пароль",
                                required: true)
                    .bindValidation(to: $viewModel.isPasswordValid)
                    .focused($currentFocus, equals: .password)
                    .onSubmit {
                        if viewModel.isValid {
                            Task { await viewModel.login() }
                        }
                    }
            }

            VStack(spacing: 8) {
                Text(viewModel.errorMessage)
                    .font(.customBody1)
                    .foregroundStyle(.customRed)

                Button("Войти") {
                    currentFocus = nil
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
                    currentFocus = nil
                    Task { await viewModel.routeToRegistration() }
                } label: {
                    Text("Зарегистрироваться")
                        .underline()
                        .font(.customCaption1)
                        .foregroundColor(.customGray)
                }
            }
        }
        .padding(16)
        .background(.white)
        .animation(.default, value: viewModel.errorMessage)
        .animation(.default, value: viewModel.isValid)
        .onTapGesture {
            currentFocus = nil
        }
    }
}

#Preview {
    LoginView()
}
