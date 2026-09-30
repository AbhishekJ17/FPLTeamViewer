//
//  DefaultPremierLeagueTeamListRepositoryTests.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import XCTest
@testable import FPLTeamViewer

final class DefaultPremierLeagueTeamUseCaseTests: XCTestCase {

    var sut: DefaultPremierLeagueTeamUseCase!
    var mockRepository: MockPremierLeagueTeamListRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockPremierLeagueTeamListRepository()
        sut = DefaultPremierLeagueTeamUseCase(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchPremierLeagueTeams_Success() async throws {
        mockRepository.shouldReturnError = false
        let result = try await sut.fetchPremierLeagueTeams()
        XCTAssertNotNil(result)
    }

    func testFetchPremierLeagueTeams_Failure() async {
        mockRepository.shouldReturnError = true
        do {
            _ = try await sut.fetchPremierLeagueTeams()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is APIError)
        }
    }
}
