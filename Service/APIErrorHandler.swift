//
//  APIErrorHandler.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

enum APIError: Error {

    case success
    case noInternetConnection
    case invalidURL
    case parsingError
    case timeout
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case badGateway
    case invalidResponse
    case unknown

    var message: String {
        switch self {
            case .success: return "Success"
            case .noInternetConnection: return "Your device is offline. Please check your Wi-Fi or cellular data."
            case .invalidURL: return "This link couldn’t be opened. Please check it and try again."
            case .parsingError: return "We couldn't process the information. Please update the app."
            case .timeout: return "The server took too long to respond. Please try again."
            case .badRequest: return "Something went wrong with your request."
            case .unauthorized: return "Your session has expired. Please log in again."
            case .notFound: return "The requested content could not be found."
            case .serverError: return "Something went wrong on our server."
            case .badGateway: return "The server is temporarily unavailable."
            case .invalidResponse: return "Something went wrong"
            case .unknown: return "Something went wrong"
        }
    }
}
