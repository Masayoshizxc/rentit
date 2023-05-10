//
//  NotificationsRouter.swift
//  MedTech
//
//  Created by Eldiiar on 8/8/22.
//

import Foundation

enum FavouritesRouter: BaseRouter {
    case getCompare(data: Data)
    case deleteById(id: Int)
    case deleteAll(userId: Int)

    var path: String {
        switch self {
        case .getCompare:
            return "/product/comparing"
        case let .deleteById(id):
            return "/api/v1/notifications/\(id)"
        case let .deleteAll(id):
            return "/api/v1/patients/\(id)/notifications"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getCompare:
            return nil
        case .deleteById:
            return nil
        case .deleteAll:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getCompare:
            return .POST
        case .deleteById:
            return .DELETE
        case .deleteAll:
            return .DELETE
        }
    }

    var httpBody: Data? {
        switch self {
        case let .getCompare(data):
            return data
        case .deleteById:
            return nil
        case .deleteAll:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getCompare:
            return nil
        case .deleteById:
            return nil
        case .deleteAll:
            return nil
        }
    }
}
