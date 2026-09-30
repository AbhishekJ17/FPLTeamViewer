//
//  DefaultPremierLeagueTeamListViewModel.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation
import Combine

protocol PremierLeagueTeamListViewModelInput {
    func fetchTeamList()
}

protocol PremierLeagueTeamListViewModelOutput {
    var errorMessage: String { get set }
    var isLoading: Bool { get set }
    var teamSummary: [TeamSummary] { get set }
    var squadSections: [SquadSection] { get set }
    var teamList: BootstrapResponse? { get set }
}

typealias PremierLeagueTeamListViewModel = PremierLeagueTeamListViewModelInput & PremierLeagueTeamListViewModelOutput

final class DefaultPremierLeagueTeamListViewModel: PremierLeagueTeamListViewModel, ObservableObject {

    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var teamSummary: [TeamSummary] = []
    @Published var squadSections: [SquadSection] = []

    var teamList: BootstrapResponse?
    private let teamListUseCase: PremierLeagueTeamListUseCase
    private let cacheService: TeamCacheServiceProtocol

    init(teamListUseCase: PremierLeagueTeamListUseCase, cacheService: TeamCacheServiceProtocol = TeamCacheService()) {
        self.teamListUseCase = teamListUseCase
        self.cacheService = cacheService
        fetchTeamList()
    }

    func fetchTeamList() {
        Task {
            self.isLoading = true
            do {
                if let teamList = try await teamListUseCase.fetchPremierLeagueTeams() {
                    self.teamList = teamList
                    self.teamSummary = teamList.teamSummaries()
                    self.cacheService.save(teamSummary)
                }
                self.isLoading = false
            } catch let error {
                if let cachedTeams = self.cacheService.load(), !cachedTeams.isEmpty {
                    self.teamSummary = cachedTeams
                }else if let apiError = error as? APIError {
                    self.errorMessage = apiError.message
                }else {
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }
    }
}
