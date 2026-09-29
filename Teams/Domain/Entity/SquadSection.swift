//
//  SquadSection.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation

struct SquadSection: Hashable, Sendable {
    let position: Position
    let players: [Player]
}
