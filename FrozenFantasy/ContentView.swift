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
        VStack(spacing: 12) {
            CustomTextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)

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

            CustomTextField("Code", text: $code)
                .keyboardType(.asciiCapableNumberPad)

            CustomTextField("Username", text: $username, tip: "Only letters and numbers")
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.never)

            CustomTextField("Password", text: $password, isSecure: true)

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
