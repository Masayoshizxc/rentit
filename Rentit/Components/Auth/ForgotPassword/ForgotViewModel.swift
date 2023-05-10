//
//  ForgotViewModel.swift
//  Rentit
//
//  Created Eldiiar on 8/11/22.
//

import Foundation

protocol ForgotViewModelProtocol {
    func forgotPassword(email: String, completion: @escaping ((SuccessFailure) -> Void))
}

class ForgotViewModel: ForgotViewModelProtocol {
    let networkService = NetworkService.shared
    
    func forgotPassword(email: String, completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: ForgotPasswordRouter.forgotPassword(email: email).createURLRequest(), successModel: FailureModel.self) { result in
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
