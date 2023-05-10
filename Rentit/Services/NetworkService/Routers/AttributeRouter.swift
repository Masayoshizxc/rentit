//
//  ChecklistRouter.swift
//  MedTech
//
//  Created by Eldiiar on 2/8/22.
//

import Foundation

enum AttributesRouter: BaseRouter {
    case getAttributes(id: Int)

    var path: String {
        switch self {
        case let .getAttributes(id):
            return "/attributes/category/\(id)"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getAttributes:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getAttributes:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getAttributes:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getAttributes:
            return nil
        }
    }
}
