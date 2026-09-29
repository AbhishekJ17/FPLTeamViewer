//
//  PremierLeagueTeamListRepository.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

protocol PremierLeagueTeamListRepository {
    func fetchPremierLeagueTeams<T: Decodable>(endPoint: APIEndPoint) async throws -> T?
}
