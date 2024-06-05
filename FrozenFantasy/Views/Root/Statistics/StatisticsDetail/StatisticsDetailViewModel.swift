//
//  StatisticsDetailViewModel.swift
//  FrozenFantasy
//
//  Created by Никита Сигал on 03.06.2024.
//

import Foundation

final class StatisticsDetailViewModel: ObservableObject {
    @Published @MainActor var matches: [MatchStats] = []

    @MainActor func average(of key: KeyPath<MatchStats, Int>) -> Double {
        let res = matches.reduce(0) { $0 + $1[keyPath: key] }
        return matches.isEmpty ? 0 : Double(res) / Double(matches.count)
    }

    @MainActor func shutoutPercentage() -> Double {
        return Double(matches.filter { $0.shutout }.count) / Double(matches.count)
    }

    func fetchMatchStats(playerID: Int) async {
        do {
            let data = try await NetworkManager.shared.request(
                from: PlayersAPI.getStats(playerID: playerID),
                expecting: [MatchStats].self)
                .sorted { $0.date > $1.date }
            await MainActor.run {
                matches = data
            }
        } catch APIError.failedWithStatusCode(code: 404) {
        } catch {
            await AppState.shared.presentAlert(message: error.localizedDescription)
        }
    }
}
