//
//  PremierLeagueTeamListUseCase.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

protocol PremierLeagueTeamListUseCase {
    func fetchPremierLeagueTeams() async throws -> BootstrapResponse?
}
