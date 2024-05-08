//
//  RegistrationView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var secondsLeft: Int = 0

    var body: some View {
        VStack(spacing: 24) {
            VStack {
                Image("applogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                Text("Регистрация")
                    .font(.customTitle1)
            }

            VStack(spacing: 4) {
                CustomTextField(.email(isNew: true), text: $viewModel.email, placeholder: "Почта", required: true)
                    .bindValidation(to: $viewModel.isEmailValid)
                Button(secondsLeft == 0
                    ? "Отправить код"
                    : "Подождите \(secondsLeft) с.") {
                    Task { await viewModel.sendCode() }
                    secondsLeft = 30
                }
                .buttonStyle(.customBordered)
                .disabled(!viewModel.isEmailValid || secondsLeft != 0)
                .onReceive(timer) { _ in
                    if secondsLeft > 0 {
                        secondsLeft -= 1
                    }
                }
                .animation(.default, value: secondsLeft == 0)

                CustomTextField(.verificationCode, text: $viewModel.code, placeholder: "Код", required: true)
                    .bindValidation(to: $viewModel.isCodeValid)
            }

            VStack(spacing: 4) {
                CustomTextField(.nickname(isNew: true),
                                text: $viewModel.nickname,
                                placeholder: "Имя пользователя",
                                tip: "Только латинские символы, цифры, тире и нижнее подчеркивание",
                                required: true)
                    .bindValidation(to: $viewModel.isNicknameValid)
                CustomTextField(.password(isNew: true),
                                text: $viewModel.password,
                                placeholder: "Пароль",
                                required: true)
                    .bindValidation(to: $viewModel.isPasswordValid)
            }

            VStack(spacing: 8) {
                Text(viewModel.errorMessage)
                    .font(.customBody1)
                    .foregroundStyle(.customRed)

                Button("Создать аккаунт") {
                    Task { await viewModel.register() }
                }
                .buttonStyle(.custom)
                .disabled(!viewModel.isValid)
            }

            Spacer()

            VStack(spacing: 0) {
                Text("Уже есть аккаунт?")
                    .font(.customCaption1)
                    .foregroundColor(.customGray)

                Button {
                    Task { await viewModel.routeToLogin() }
                } label: {
                    Text("Войти")
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
    RegistrationView()
}
