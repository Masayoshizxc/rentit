//
//  ProfileRouter.swift
//  MedTech
//
//  Created by Eldiiar on 16/7/22.
//

import Foundation

enum ProfileeRouter: BaseRouter {
    case getUser
    case getMyProducts

    var path: String {
        switch self {
        case .getUser:
            return "/user/my"
        case .getMyProducts:
            return "/product/my"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getUser:
            return nil
        case .getMyProducts:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getUser:
            return .GET
        case .getMyProducts:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getUser:
            return nil
        case .getMyProducts:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getUser:
            return nil
        case .getMyProducts:
            return nil
        }
    }
}
