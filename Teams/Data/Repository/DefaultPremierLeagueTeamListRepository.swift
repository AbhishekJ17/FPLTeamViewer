//
//  DefaultPremierLeagueTeamListRepository.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

class DefaultPremierLeagueTeamListRepository: PremierLeagueTeamListRepository {

    func fetchPremierLeagueTeams<T>(endPoint: any APIEndPoint) async throws -> T? where T : Decodable {
        do {
            return try await APIClient.shared.performRequest(with: endPoint)
        } catch let error as APIError {
            throw error
        }
    }
}
