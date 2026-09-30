//
//  MockPremierLeagueTeamListRepository.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import XCTest
@testable import FPLTeamViewer

final class MockPremierLeagueTeamListRepository: PremierLeagueTeamListRepository {
    var shouldReturnError = false
    var mockResponse: BootstrapResponse?

    func fetchPremierLeagueTeams<T>(endPoint: any APIEndPoint) async throws -> T? where T : Decodable {
        if shouldReturnError {
            throw APIError.notFound
        }
        return mockResponse as? T
    }
}
