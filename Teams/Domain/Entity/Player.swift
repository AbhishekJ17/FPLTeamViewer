//
//  Player.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation

struct Player: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let team: Int               // matches Team.id, used to build squads + player counts
    let elementType: Int        // 1 GKP, 2 DEF, 3 MID, 4 FWD
    let webName: String         // display name, e.g. "Raya"
    let firstName: String       // search only (so "David Raya" matches)
    let secondName: String      // search only
    let nowCost: Int            // tenths of a million: 61 == £6.1m
    let totalPoints: Int

    enum CodingKeys: String, CodingKey {
        case id
        case team
        case elementType = "element_type"
        case webName = "web_name"
        case firstName = "first_name"
        case secondName = "second_name"
        case nowCost = "now_cost"
        case totalPoints = "total_points"
    }
}

extension Player {
    /// Nil if the API ever returns an unknown element type (won't break decoding).
    var position: Position? { Position(rawValue: elementType) }

    var price: Double { Double(nowCost) / 10.0 }
    var priceText: String { String(format: "£%.1fm", price) }

    var fullName: String { "\(firstName) \(secondName)" }
}
