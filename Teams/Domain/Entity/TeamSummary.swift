//
//  TeamSummary.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation

struct TeamSummary: Identifiable, Hashable, Sendable, Codable {
    let team: Team
    let playerCount: Int
    var id: Int { team.id }
}

extension TeamSummary {
    init() {
        self.team = .init(id: 1, name: "Arsenal", shortName: "ars")
        self.playerCount = 20
    }
}
