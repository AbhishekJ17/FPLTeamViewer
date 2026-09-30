//
//  MockPremierLeagueTeamListUseCase.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import XCTest
@testable import FPLTeamViewer

final class MockPremierLeagueTeamListUseCase: PremierLeagueTeamListUseCase {
    var mockResponse: BootstrapResponse?
    var shouldThrowError = false

    func fetchPremierLeagueTeams() async throws -> BootstrapResponse? {
        if shouldThrowError {
            throw APIError.notFound
        }
        return mockResponse
    }
}
