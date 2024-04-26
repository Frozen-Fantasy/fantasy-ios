//
//  ProfileView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile View Placeholder")
                .font(.customTitle1)
            
            Button("Выйти из аккаунта") {
                Task {
                    let _ = try await NetworkManager.shared.request(
                        endpoint: AuthAPI.logout(
                            refreshToken: TokenManager.shared.tokenPair.refreshToken
                        )
                    ).data()
                    TokenManager.shared.deleteTokens()
                }
            }
            .buttonStyle(.custom)
        }
    }
}

#Preview {
    ProfileView()
}
