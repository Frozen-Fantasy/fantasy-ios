//
//  TournamentDetailViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 15.05.2024.
//

import Foundation

final class TournamentDetailViewModel: ObservableObject {
    @MainActor @Published var tournament: Tournament?
    @MainActor @Published var matches: Matches = []
    @MainActor @Published var players: Players = []

    func fetchTournament() async {
        guard let tournamentID = await tournament?.id else { return }
        do {
            guard let data = try await NetworkManager.shared.request(
                    from: TournamentsAPI.getTournaments(
                        showAll: true,
                        tournamentID: tournamentID,
                        league: nil,
                        status: nil),
                    expecting: Tournaments.self).first
            else { throw APIError.badRequest(reason: "Турнир не найден") }
            await MainActor.run {
                tournament = data
            }

        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func fetchTeam() async {
        guard let tournamentID = await tournament?.id else { return }
        do {
            let data = try await NetworkManager.shared.request(
                from: TournamentsAPI.getTeam(tournamentID: tournamentID),
                expecting: Roster.self).players
                .sorted { left, right in
                    left.position.rawValue > right.position.rawValue
                        || left.position == right.position && left.averageFP > right.averageFP
                }
            await MainActor.run {
                players = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }

    func fetchMatches() async {
        guard let tournamentID = await tournament?.id else { return }
        do {
            let data: Matches = try await NetworkManager.shared.request(
                from: TournamentsAPI.getMatches(tournamentID: tournamentID),
                expecting: Matches.self)
            await MainActor.run {
                matches = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
