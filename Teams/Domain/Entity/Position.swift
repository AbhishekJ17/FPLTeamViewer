//
//  Position.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

enum Position: Int, CaseIterable, Sendable {
    case goalkeeper = 1, defender, midfielder, forward

    /// Section header
    var title: String {
        switch self {
        case .goalkeeper: return "Goalkeepers"
        case .defender:   return "Defenders"
        case .midfielder: return "Midfielders"
        case .forward:    return "Forwards"
        }
    }

    /// Per-row label
    var shortName: String {
        switch self {
        case .goalkeeper: return "GKP"
        case .defender:   return "DEF"
        case .midfielder: return "MID"
        case .forward:    return "FWD"
        }
    }
}
