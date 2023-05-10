//
//  ProductRouter.swift
//  Rentit
//
//  Created by Eldiiar on 13/11/22.
//

import Foundation

enum ProductRouter: BaseRouter {
    case postProduct(data: Data)
    case getProduct
    case getProductById(id: Int)
    case postCompare(data: Data)
    
    var path: String {
        switch self {
        case .postProduct:
            return "/product/save"
        case .getProduct:
            return "/product/basic"
        case let .getProductById(id):
            return "/product/basic/\(id)"
        case .postCompare:
            return "/product/basic/comparing"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case .postProduct:
            return nil
        case .getProduct:
            return nil
        case .getProductById:
            return nil
        case .postCompare:
            return nil
        }
    }

    var method: HttpMethod {
        switch self {
        case .postProduct:
            return .POST
        case .getProduct:
            return .GET
        case .getProductById:
            return .GET
        case .postCompare:
            return .POST
        }
    }

    var httpBody: Data? {
        switch self {
        case let .postProduct(data):
            return data
        case .getProduct:
            return nil
        case .getProductById:
            return nil
        case .postCompare:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .postProduct:
            return nil
        case .getProduct:
            return nil
        case .getProductById:
            return nil
        case .postCompare:
            return nil
        }
    }
}
