//
//  TeamSummary.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation

struct TeamSummary: Identifiable, Hashable, Sendable {
    let team: Team
    let playerCount: Int
    var id: Int { team.id }
}
