//
//  BabyDevelopmentRouter.swift
//  MedTech
//
//  Created by Eldiiar on 12/7/22.
//

import Foundation

enum MapNetworkRouter: BaseRouter {
    case getAllLocations
    
    var path: String {
        switch self {
        case .getAllLocations:
            return "/api/sports_areas/for_map/"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAllLocations:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getAllLocations:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getAllLocations:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAllLocations:
            return nil
        }
    }
}
