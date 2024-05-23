//
//  TeamViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 23.05.2024.
//

import Foundation

final class TeamViewModel: ObservableObject {
    @MainActor @Published var players: Players = []
    @Published var selectedPosition: Position?

    @MainActor var visiblePlayers: Players {
        players.filter { player in
            if let selectedPosition, player.position != selectedPosition {
                return false
            }

            return true
        }
        .sorted { left, right in
            selectedPlayers.contains(left) && !selectedPlayers.contains(right)
        }
    }

    @MainActor @Published var selectedPlayers: Set<Player> = .init()

    @MainActor func canContain(_ position: Position) -> Bool {
        selectedPlayers.filter { $0.position == position }.count < position.rawValue
    }

    func fetchPlayers() async {
        await MainActor.run {
            players = [.dummy]
        }
    }
}
