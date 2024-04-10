//
//  ContentView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var code: String = ""
    @State var password: String = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField("email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .font(.customBody)


            Button("Send code") {
                Task {
                    do {
                        let data = try await NetworkManager.shared.request(
                            endpoint: AuthAPI.sendEmail(email: email)
                        ).data(as: [String: String].self)
                        print(data)
                    } catch {
                        print(error)
                    }
                }
            }
            .buttonStyle(.customBordered)

            TextField("code", text: $code)
                .keyboardType(.asciiCapableNumberPad)
                .font(.customBody)

            TextField("nickname", text: $username)
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)
                .font(.customBody)

            SecureField("password", text: $password)
                .font(.customBody)

            Button("Sign up") {
                Task {
                    do {
                        let data = try await NetworkManager.shared.request(
                            endpoint: AuthAPI.signUp(
                                code: Int(code)!,
                                email: email,
                                username: username,
                                password: password
                            )
                        ).data(as: [String: String].self)
                        print(data)
                    } catch {
                        print(error)
                    }
                }
            }
            .buttonStyle(.custom)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
