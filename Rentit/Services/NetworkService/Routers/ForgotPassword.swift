//
//  ForgotPassword.swift
//  MedTech
//
//  Created by Eldiiar on 6/7/22.
//

import Foundation

enum ForgotPasswordRouter: BaseRouter {
    case forgotPassword(email: String)
    case resetPassword(code: String, email: String)
    case changePassword(code: String, password: String)
    
    var path: String {
        switch self {
        case .forgotPassword:
            return "/api/auth/resetPassword"
        case .resetPassword:
            return "/api/auth/verifyPasswordResetToken"
        case .changePassword:
            return "/api/auth/changePassword"
        }
    }

    var queryParameter: [URLQueryItem]? {
        switch self {
        case let .forgotPassword(email):
            return [URLQueryItem(name: "userEmail", value: email)]
        case let .resetPassword(code, email):
            return [
                URLQueryItem(name: "token", value: code),
                URLQueryItem(name: "email", value: email)
            ]
        case let .changePassword(code, password):
            return [
                URLQueryItem(name: "token", value: code),
                URLQueryItem(name: "newPassword", value: password)
            ]
        }
    }

    var method: HttpMethod {
        switch self {
        case .forgotPassword:
            return .POST
        case .resetPassword:
            return .GET
        case .changePassword:
            return .POST
            
        }
    }

    var httpBody: Data? {
        switch self {
        case .forgotPassword:
            return nil
        case .resetPassword:
            return nil
        case .changePassword:
            return nil
        }
    }

    var httpHeader: [HttpHeader]? {
        switch self {
        case .forgotPassword:
            return nil
        case .resetPassword:
            return nil
        case .changePassword:
            return nil
        }
    }
}
