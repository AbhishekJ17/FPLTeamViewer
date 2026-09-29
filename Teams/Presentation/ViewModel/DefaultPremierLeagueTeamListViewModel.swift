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
}

typealias PremierLeagueTeamListViewModel = PremierLeagueTeamListViewModelInput & PremierLeagueTeamListViewModelOutput

final class DefaultPremierLeagueTeamListViewModel: PremierLeagueTeamListViewModel, ObservableObject {

    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var teamSummary: [TeamSummary] = []

    private let teamListUseCase: PremierLeagueTeamListUseCase

    init(teamListUseCase: PremierLeagueTeamListUseCase) {
        self.teamListUseCase = teamListUseCase
        fetchTeamList()
    }

    func fetchTeamList() {
        Task {
            self.isLoading = true
            do {
                if let teamList = try await teamListUseCase.fetchPremierLeagueTeams() {
                    self.teamSummary = teamList.teamSummaries()
                }
            } catch let error as APIError {
                self.errorMessage = error.message
            }
            self.isLoading = false
        }
    }
}

