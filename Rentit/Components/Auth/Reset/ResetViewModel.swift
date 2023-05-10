//
//  ResetViewModel.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import Foundation

protocol ResetViewModelProtocol {
    func resetPassword(code: String, email: String, completion: @escaping ((SuccessFailure) -> Void))
}

class ResetViewModel: ResetViewModelProtocol {
    let networkService = NetworkService.shared
    
    func resetPassword(code: String, email: String, completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: ForgotPasswordRouter.resetPassword(code: code, email: email).createURLRequest(), successModel: FailureModel.self) { result in
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
