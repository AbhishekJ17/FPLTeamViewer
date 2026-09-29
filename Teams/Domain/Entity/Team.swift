//
//  Team.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

struct Team: Codable, Identifiable, Hashable, Sendable {
    let id: Int
    let name: String
    let shortName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
    }
}
