//
//  DefaultPremierLeagueTeamUseCase.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

class DefaultPremierLeagueTeamUseCase: PremierLeagueTeamListUseCase {

    private let repository: PremierLeagueTeamListRepository

    init(repository: PremierLeagueTeamListRepository) {
        self.repository = repository
    }

    func fetchPremierLeagueTeams() async throws -> BootstrapResponse? {
        do {
            let teamEndPoint: TeamEndPoint = .teams
            return try await repository.fetchPremierLeagueTeams(endPoint: teamEndPoint)
        } catch let error as APIError {
            throw error
        }
    }
}
