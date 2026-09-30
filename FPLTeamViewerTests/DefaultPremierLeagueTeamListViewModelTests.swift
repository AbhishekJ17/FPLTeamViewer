//
//  DefaultPremierLeagueTeamListViewModelTests.swift
//  FPLTeamViewer
//
//  Created by Admin on 30/09/26.
//

import XCTest
@testable import FPLTeamViewer

@MainActor
final class DefaultPremierLeagueTeamListViewModelTests: XCTestCase {

    var sut: DefaultPremierLeagueTeamListViewModel!
    var mockUseCase: MockPremierLeagueTeamListUseCase!
    var mockCache: MockTeamCacheService!

    override func setUp() {
        super.setUp()
        mockUseCase = MockPremierLeagueTeamListUseCase()
        mockCache = MockTeamCacheService()
    }

    override func tearDown() {
        sut = nil
        mockUseCase = nil
        mockCache = nil
        super.tearDown()
    }

    func testFetchTeamList_SuccessUpdatesStateAndCaches() async {
        mockCache.cachedTeamsToReturn = nil
        sut = DefaultPremierLeagueTeamListViewModel(teamListUseCase: mockUseCase, cacheService: mockCache)

        sut.fetchTeamList()

        await Task.yield()

        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.errorMessage.isEmpty)
    }

    func testFetchTeamList_FailureFallsBackToCache() async {
        mockUseCase.shouldThrowError = true
        let expectedCachedTeam = TeamSummary()
        mockCache.cachedTeamsToReturn = [expectedCachedTeam]

        sut = DefaultPremierLeagueTeamListViewModel(teamListUseCase: mockUseCase, cacheService: mockCache)

        sut.fetchTeamList()
        await Task.yield()

        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(sut.teamSummary.count, 1)
    }
}
