//
//  NetworkService.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation

protocol NetworkService {
    func performRequest<T: Decodable>(with endPoint: APIEndPoint) async throws -> T?
}

final actor APIClient: NetworkService {

    private let session: URLSession
    private let baseURL = URL(string: "https://fantasy.premierleague.com/api/")!

    private var isNetworkConnectionOn: Bool {
        true
    }

    static let shared: APIClient = {
        return APIClient()
    }()

    private init() {
        session = URLSession.shared
    }


    func performRequest<T: Decodable>(with endPoint: any APIEndPoint) async throws -> T? {
        guard isNetworkConnectionOn else {
            throw APIError.noInternetConnection
        }
        var component = URLComponents(
            url: baseURL.appending(path: endPoint.path),
            resolvingAgainstBaseURL: true
        )

        component?.queryItems = endPoint.queryItems

        guard let url = component?.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.timeoutInterval = 10

        do {
            let (data, response) = try await session.data(for: request)
            try handle(urlResponse: response)
            let result = try parseResponseforThis(type: T.self, data: data)
            return result
        } catch let error as APIError {
            throw error
        }
    }

    private func parseResponseforThis<T: Decodable>(type: T.Type, data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw APIError.parsingError
        }
    }

    private func handle(urlResponse: URLResponse) throws {
        guard let response = urlResponse as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        switch response.statusCode {
        case 200: return
        case 400: throw APIError.badRequest
        case 401: throw APIError.unauthorized
        case 404: throw APIError.notFound
        case 500: throw APIError.serverError
        case 502: throw APIError.badGateway
        default: return
        }
    }
}






