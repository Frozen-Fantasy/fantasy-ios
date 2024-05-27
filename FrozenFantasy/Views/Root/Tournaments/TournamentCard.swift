//
//  TournamentCard.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 22.04.2024.
//

import SwiftUI

struct TournamentCard: View {
    @State private var tournamentStatus: Status
    @State private var secondsLeft: TimeInterval = 0
    @State private var timer: Timer?
    private var timeLeftString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: secondsLeft) ?? "00:00:00"
    }

    let tournament: Tournament
    init(_ tournament: Tournament) {
        self.tournament = tournament
        self.tournamentStatus = tournament.status
    }

    private var statusLabel: some View {
        switch tournamentStatus {
        case .notStarted:
            if tournament.participating {
                Text("Ожидает начала")
                    .foregroundStyle(.customOrange)
            } else {
                Text("Предстоящий")
                    .foregroundStyle(.customBlue)
            }
        case .started:
            Text("Идет сейчас")
                .foregroundStyle(.customGreen)
        case .finished:
            Text("Завершён")
                .foregroundStyle(.customGray)
        }
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
                statusLabel
                    .font(.customCaption2)

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

                    switch tournamentStatus {
                    case .notStarted:
                        Text("До начала **\(timeLeftString)**")
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)
                    case .started:
                        Text("До окончания **\(timeLeftString)**")
                            .font(.customBody1)
                            .foregroundStyle(.customBlack)
                    case .finished:
                        Text(tournament.endDate.formatted(date: .long, time: .omitted))
                            .font(.customBody1)
                            .bold()
                            .foregroundStyle(.customBlack)
                    }
                }
            }
        }
        .padding(12)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .shadow(color: .black.opacity(0.1), radius: 8, x: 2, y: 2)
        .animation(.default, value: tournamentStatus)
        .onAppear {
            if tournamentStatus != .finished {
                secondsLeft = (tournamentStatus == .notStarted
                                ? tournament.startDate
                                : tournament.endDate)
                    .timeIntervalSinceNow

                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    if secondsLeft == 0 {
                        tournamentStatus = .started
                        timer?.invalidate()
                    } else {
                        secondsLeft -= 1
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
