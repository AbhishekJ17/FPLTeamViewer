//
//  TeamEndPoint.swift
//  FPLTeamViewer
//
//  Created by Admin on 29/09/26.
//

import Foundation

enum TeamEndPoint: APIEndPoint {

    case teams  

    var path: String {
        "bootstrap-static"
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem] {
        []
    }

    var headers: [String : String] {
        [:]
    }

    var body: [String : Any]? {
        nil
    }


}
