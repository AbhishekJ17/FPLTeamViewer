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

// MARK: - Transformations for the two screens

/// Row model for the Teams screen.
struct TeamSummary: Identifiable, Hashable, Sendable {
    let team: Team
    let playerCount: Int
    var id: Int { team.id }
}

/// Section model for the Team Squad screen.
struct SquadSection: Hashable, Sendable {
    let position: Position
    let players: [Player]
}

extension BootstrapResponse {

    /// Teams screen data: teams (A–Z) with the number of players in each.
    func teamSummaries() -> [TeamSummary] {
        let counts = Dictionary(grouping: elements, by: \.team).mapValues(\.count)
        return teams
            .map { TeamSummary(team: $0, playerCount: counts[$0.id] ?? 0) }
            .sorted { $0.team.name.localizedCaseInsensitiveCompare($1.team.name) == .orderedAscending }
    }

    /// All players that belong to a team.
    func players(forTeam teamID: Int) -> [Player] {
        elements.filter { $0.team == teamID }
    }
}

enum SquadBuilder {

    /// Groups players by position (GKP → FWD), orders each group by total points
    /// (highest first, name as tie-break), and applies an optional search query.
    /// Positions with no matching players are omitted, so an empty array means "no results".
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

    /// Case- and diacritic-insensitive match against the display name and full name
    /// (e.g. "jurrien" matches "Jurriën"). Note: characters like "Ø" are not
    /// combining accents, so "Odegaard" will not match "Ødegaard".
    static func filter(_ players: [Player], query: String) -> [Player] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return players }
        return players.filter {
            $0.webName.range(of: trimmed, options: [.caseInsensitive, .diacriticInsensitive]) != nil
            || $0.fullName.range(of: trimmed, options: [.caseInsensitive, .diacriticInsensitive]) != nil
        }
    }
}
