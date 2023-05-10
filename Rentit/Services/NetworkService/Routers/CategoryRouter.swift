//
//  AppointmentsRouter.swift
//  MedTech
//
//  Created by Eldiiar on 14/7/22.
//

import Foundation

enum CategoryRouter: BaseRouter {
    case getCategory
    case getSubCategory(id: Int)
    
    var path: String {
        switch self {
        case .getCategory:
            return "/category/"
        case let .getSubCategory(id):
            return "/category/subcategories/\(id)"
        }
        
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .getCategory:
            return nil
        case .getSubCategory:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .getCategory:
            return .GET
        case .getSubCategory:
            return .GET
        }
    }

    var httpBody: Data? {
        switch self {
        case .getCategory:
            return nil
        case .getSubCategory:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .getCategory:
            return nil
        case .getSubCategory:
            return nil
        }
    }
}
