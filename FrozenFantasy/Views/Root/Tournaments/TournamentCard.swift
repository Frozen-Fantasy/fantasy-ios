//
//  TournamentCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentCard: View {
    @State var tournament: Tournament

    @State var secondsUntilStart: TimeInterval = 0
    @State private var timer: Timer?
    private var timeUntilStart: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: secondsUntilStart) ?? "00:00:00"
    }

    init(_ tournament: Tournament) {
        self.tournament = tournament
    }

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(spacing: 0) {
                Image("logo:\(tournament.league)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)

                CustomLabel("1 день", image: "icon:calendar")
                    .foregroundStyle(.customGray)
            }

            VStack(alignment: .leading, spacing: 0) {
                Text(tournament.status.displayed)
                    .font(.customCaption2)
                    .foregroundStyle(.customGray)
                Text(tournament.title)
                    .font(.customTitle3)
                    .foregroundStyle(.customBlack)

                HStack(spacing: 12) {
                    VStack(spacing: 4) {
                        Text("Взнос")
                        Text("Фонд")
                    }
                    .font(.customBody1)
                    .foregroundStyle(.customBlack)

                    VStack(alignment: .leading, spacing: 4) {
                        CoinLabel(tournament.deposit)
                        CoinLabel(tournament.prizeFund)
                    }
                }
                .padding(.top, 4)

                Spacer()

                HStack(spacing: 0) {
                    CustomLabel(tournament.players.formatted(), image: "icon:group")
                        .foregroundStyle(.customGray)

                    Spacer()

                    Group {
                        if secondsUntilStart > 0 {
                            Text("До начала ")
                                .font(.customBody1)
                                + Text(timeUntilStart)
                                .font(.customBodyMedium1)
                        } else {
                            Text("Уже начался!")
                                .font(.customBody1)
                        }
                    }
                    .foregroundStyle(.customBlack)
                }
            }
        }
        .padding(12)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.2), radius: 8, x: 2, y: 2)
        .animation(.default, value: secondsUntilStart == 0)
        .onAppear {
            if tournament.status == .notStarted {
                secondsUntilStart = tournament.startDate.timeIntervalSinceNow
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    if secondsUntilStart == 0 {
                        timer?.invalidate()
                    } else {
                        secondsUntilStart -= 1
                    }
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

#Preview {
    TournamentCard(.dummy)
        .padding()
}
