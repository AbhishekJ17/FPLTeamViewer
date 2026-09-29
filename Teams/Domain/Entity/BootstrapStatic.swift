//
//  BootstrapStatic.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation

struct BootstrapResponse: Codable, Equatable, Sendable {
    let teams: [Team]
    let elements: [Player]
}

extension BootstrapResponse {

    func teamSummaries() -> [TeamSummary] {
        let counts = Dictionary(grouping: elements, by: \.team).mapValues(\.count)
        return teams
            .map { TeamSummary(team: $0, playerCount: counts[$0.id] ?? 0) }
            .sorted { $0.team.name.localizedCaseInsensitiveCompare($1.team.name) == .orderedAscending }
    }

    func players(forTeam teamID: Int) -> [Player] {
        elements.filter { $0.team == teamID }
    }
}

enum SquadBuilder {

    static func sections(from players: [Player], query: String = "") -> [SquadSection] {
        let filtered = filter(players, query: query)
        let grouped = Dictionary(grouping: filtered.compactMap { player in
            player.position.map { ($0, player) }
        }, by: { $0.0 }).mapValues { $0.map(\.1) }

        return Position.allCases.compactMap { position in
            guard let group = grouped[position], !group.isEmpty else { return nil }
            let sorted = group.sorted {
                if $0.totalPoints != $1.totalPoints { return $0.totalPoints > $1.totalPoints }
                return $0.webName.localizedCaseInsensitiveCompare($1.webName) == .orderedAscending
            }
            return SquadSection(position: position, players: sorted)
        }
    }

    static func filter(_ players: [Player], query: String) -> [Player] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return players }
        return players.filter {
            $0.webName.range(of: trimmed, options: [.caseInsensitive, .diacriticInsensitive]) != nil
            || $0.fullName.range(of: trimmed, options: [.caseInsensitive, .diacriticInsensitive]) != nil
        }
    }
}
