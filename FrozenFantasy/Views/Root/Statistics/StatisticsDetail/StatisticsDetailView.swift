//
//  StatisticsDetailView.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import SwiftUI
import SwiftUIIntrospect

struct StatisticsDetailView: View {
    @StateObject var viewModel = StatisticsDetailViewModel()

    let player: Player

    init(_ player: Player) {
        self.player = player
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    HStack(spacing: 24) {
                        CustomImage(url: player.photo) { image in
                            GeometryReader { geometry in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height,
                                           alignment: .top)
                                    .background(.white)
                            }
                        }
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
                        .frame(width: 80, height: 80)

                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .firstTextBaseline) {
                                Text(player.name)
                                    .font(.customTitle2)
                                    .foregroundStyle(.customBlack)

                                Text("#\(player.sweaterNumber)")
                                    .font(.customTitle4)
                                    .foregroundStyle(.customGray)

                                Text(player.position.abbreviation)
                                    .font(.customBody1)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(player.position.color)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                            }
                            HStack(spacing: 0) {
                                CustomImage(url: player.teamLogo) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 40, height: 28)

                                Text(player.teamName)
                                    .font(.customTitle4)
                                    .foregroundStyle(.customBlack)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    HStack(alignment: .firstTextBaseline) {
                        Spacer()
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("AvFP")
                                .font(.customBody1)
                                .foregroundStyle(.customBlack)

                            FantasyPointLabel(player.averageFP)
                        }
                        .frame(width: 100, alignment: .leading)
                        Spacer()
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("Cost")
                                .font(.customBody1)
                                .foregroundStyle(.customBlack)

                            Text(player.cost
                                    .formatted(.currency(code: "USD")
                                                .rounded(rule: .toNearestOrAwayFromZero,
                                                         increment: 0.1)))
                                .font(.customBody1)
                                .bold()
                                .foregroundStyle(.customBlack)
                        }
                        Spacer()
                    }

                    if viewModel.matches.isEmpty {
                        Text("Нет статистики за этот сезон")
                            .font(.customTitle4)
                            .foregroundStyle(.customGray)
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("В среднем за сезон")
                                .font(.customTitle3)

                            HStack {
                                switch player.position {
                                case .goaltender:
                                    Spacer()
                                    StatLabel("SV", value: viewModel.average(of: \.saves))
                                    Spacer()
                                    StatLabel("GA", value: viewModel.average(of: \.missed))
                                    Spacer()
                                    StatLabel("PIM", value: viewModel.average(of: \.pims))
                                    Spacer()
                                    StatLabel("SO", value: viewModel.shutoutPercentage())
                                    Spacer()
                                case .defender, .forward:
                                    Spacer()
                                    StatLabel("G", value: viewModel.average(of: \.goals))
                                    Spacer()
                                    StatLabel("A", value: viewModel.average(of: \.assists))
                                    Spacer()
                                    StatLabel("HIT", value: viewModel.average(of: \.hits))
                                    Spacer()
                                    StatLabel("S", value: viewModel.average(of: \.shots))
                                    Spacer()
                                    StatLabel("PIM", value: viewModel.average(of: \.pims))
                                    Spacer()
                                }
                            }
                            .font(.customBody1)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("По играм")
                                .font(.customTitle3)

                            VStack {
                                ForEach(viewModel.matches) { matchStats in
                                    MatchStatsCard(matchStats, playerPosition: player.position)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Статистика игрока")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchMatchStats(playerID: player.id)
            }
            .introspect(.sheet, on: .iOS(.v15, .v16, .v17)) { sheet in
                let vc = sheet as UISheetPresentationController
                vc.detents = [.medium(), .large()]
                vc.prefersGrabberVisible = true
                vc.preferredCornerRadius = 40.0
            }
        }
    }
}

private struct StatisticsDetailViewPreviewContainer: View {
    @State var isPresented: Bool = false

    var body: some View {
        Button("show") {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            StatisticsDetailView(.dummy)
        }
    }
}

#Preview {
    StatisticsDetailViewPreviewContainer()
}
