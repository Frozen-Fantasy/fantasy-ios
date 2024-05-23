//
//  TeamViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import Foundation
import SwiftUI

final class TeamViewModel: ObservableObject {
    var tournamentID: Int = 0

    @Published var selectedPosition: Position?
    @Published var currentBudget = Constants.Tournaments.maxBudget

    @MainActor @Published var players: Players = []
    @MainActor @Published var selectedPlayers: Set<Player> = .init()
    @MainActor var visiblePlayers: Players {
        players.filter { player in
            if let selectedPosition, player.position != selectedPosition {
                return false
            }

            return true
        }
        .sorted { left, right in
            isSelected(left) && !isSelected(right)
                || isSelected(left) == isSelected(right) && left.averageFP > right.averageFP
        }
    }

    func fetchPlayers() async {
        do {
            let data = try await NetworkManager.shared.request(
                from: TournamentsAPI.getRoster(tournamentID: tournamentID),
                expecting: Roster.self
            ).players
            await MainActor.run {
                players = data
            }
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}

// MARK: Selection Management

extension TeamViewModel {
    @MainActor private func canContain(_ position: Position) -> Bool {
        selectedPlayers.filter { $0.position == position }.count < position.rawValue
    }

    @MainActor private func isSelected(_ player: Player) -> Bool {
        selectedPlayers.contains(player)
    }

    @MainActor private func isAffordable(_ player: Player) -> Bool {
        player.cost <= currentBudget
    }

    @MainActor func isEnabled(_ player: Player) -> Bool {
        isSelected(player) || canContain(player.position) && isAffordable(player)
    }

    @MainActor private func addPlayer(_ player: Player) {
        selectedPlayers.insert(player)
        currentBudget -= player.cost
    }

    @MainActor private func removePlayer(_ player: Player) {
        selectedPlayers.remove(player)
        currentBudget += player.cost
    }

    @MainActor func createBinding(for player: Player) -> Binding<Bool> {
        .init(
            get: {
                self.isSelected(player)
            },
            set: { newValue in
                if newValue {
                    self.addPlayer(player)
                } else {
                    self.removePlayer(player)
                }
            }
        )
    }
}
