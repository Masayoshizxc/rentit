//
//  ChangePasswordRouter.swift
//  MedTech
//
//  Created by Eldiiar on 5/7/22.
//

import Foundation

enum HomeNetworkRouter: BaseRouter {
    case getSportAreas
    case getDetails(id: Int)

    var path: String {
        switch self {
        case .getSportAreas:
            return "/api/sports_areas/"
        case let .getDetails(id):
            return "/api/sports_area/detail/\(id)/"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getSportAreas:
            return nil
        case .getDetails:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getSportAreas:
            return .GET
        case .getDetails:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getSportAreas:
            return nil
        case .getDetails:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getSportAreas:
            return nil
        case .getDetails:
            return nil
        }
    }
}
