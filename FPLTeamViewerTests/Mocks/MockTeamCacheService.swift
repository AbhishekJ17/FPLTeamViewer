//
//  MockTeamCacheService.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import XCTest
@testable import FPLTeamViewer

final class MockTeamCacheService: TeamCacheServiceProtocol {
    var savedTeams: [TeamSummary] = []
    var cachedTeamsToReturn: [TeamSummary]?

    func save(_ data: [TeamSummary]) {
        savedTeams = data
    }

    func load() -> [TeamSummary]? {
        return cachedTeamsToReturn
    }
}
