//
//  ProfileView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerView
                    
                    transactionsView
                }
                .padding()
            }
            .navigationTitle("Профиль")
            .toolbar {
                ToolbarItem(placement: .destructiveAction) {
                    Button(role: .destructive) {} label: {
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
                        Text("10 000")
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
                AsyncImage(url: URL(string: "https://cdn1.iconfinder.com/data/icons/sport-avatar-6/64/15-hockey_player-sport-hockey-avatar-people-256.png")!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
                .frame(height: 80)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("PreviewNickname")
                        .font(.customTitle2)
                    Text("preview@server.domain")
                        .font(.customBody1)
                }
                .foregroundStyle(.customBlack)
                .lineLimit(1)
                
                Spacer()
            }
            
            Text("На сервисе с марта 2024")
                .font(.customBody1)
                .foregroundStyle(.customGray)
        }
    }
    
    private var transactionsView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("История операций")
                .font(.customTitle1)
                .foregroundStyle(.customBlack)
            
            ForEach(10..<13) { i in
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(i) апреля")
                        .font(.customTitle3)
                        .foregroundStyle(.customBlack)
                        
                    VStack(spacing: 12) {
                        ForEach(0..<i - 9) { _ in
                            HStack(spacing: 8) {
                                Text("Покупка: Набор серебряных карточек НХЛ")
                                    .font(.customBody1)
                                    .bold()
                                    .lineLimit(2)
                                    
                                Spacer()
                                HStack(spacing: 4) {
                                    Text("–500")
                                        .font(.customBody1)
                                        .bold()
                                        .foregroundStyle(.customRed)
                                    Image("icon:coins")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.customYellow)
                                }
                                .fixedSize()
                            }
                            .padding(12)
                            .background(.white)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12)
                            )
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AppState())
}
