//
//  SignInRouter.swift
//  MedTech
//
//  Created by Eldiiar on 5/7/22.
//

import Foundation

enum AuthRouter: BaseRouterLogin {
    case signIn(data: Data)
    case signUp(data: Data)
    case fullSingUp(data: Data)
    case logout(data: Data)
    case refreshToken(data: Data)

    var path: String {
        switch self {
        case .signIn:
            return "/api/auth/signin"
        case .signUp:
            return "/api/auth/signup"
        case .fullSingUp:
            return "/api/auth/full-registration"
        case .logout:
            return "/api/auth/logout"
        case .refreshToken:
            return "/api/auth/refreshtoken"
        }
    }
    
    var queryParameter: [URLQueryItem]? {
        switch self {
        case .signIn:
            return nil
        case .signUp:
            return nil
        case .fullSingUp:
            return nil
        case .logout:
            return nil
        case .refreshToken:
            return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .signIn:
            return .POST
        case .signUp:
            return .POST
        case .fullSingUp:
            return .POST
        case .logout:
            return .POST
        case .refreshToken:
            return .POST
        }
    }
    
    var httpBody: Data? {
        switch self {
        case let .signIn(data):
            return data
        case let .signUp(data):
            return data
        case let .fullSingUp(data):
            return data
        case let .logout(data):
            return data
        case let .refreshToken(data):
            return data
        }
    }
    
    var httpHeader: [HttpHeader]? {
        switch self {
        case .signIn:
            return nil
        case .signUp:
            return nil
        case .fullSingUp:
            return nil
        case .logout:
            return nil
        case .refreshToken:
            return nil
        }
    }
}
