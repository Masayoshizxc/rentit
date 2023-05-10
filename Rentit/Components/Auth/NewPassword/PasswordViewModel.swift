//
//  PasswordViewModel.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import Foundation

protocol PasswordViewModelProtocol {
    func changePassword(code: String, password: String, completion: @escaping ((SuccessFailure) -> Void))
}

class PasswordViewModel: PasswordViewModelProtocol {
    let networkService = NetworkService.shared
    
    func changePassword(code: String, password: String, completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: ForgotPasswordRouter.changePassword(code: code, password: password).createURLRequest(), successModel: FailureModel.self) { result in
            switch result {
            case .success(let model):
                print(model)
                completion(.success)
            case .badRequest(let error):
                debugPrint(#function, error)
                completion(.failure)
            case .failure(let error):
                debugPrint(#function, error)
                completion(.failure)
            case .unauthorized(let error):
                debugPrint(#function, error)
                completion(.failure)
            case .notFound(let error):
                debugPrint(#function, error)
                completion(.failure)
            }
        }
    }
}
