//
//  FullViewModel.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import Foundation

protocol FullViewModelProtocol {
    func signUp(params: [String : Any], completion: @escaping ((SuccessFailure) -> Void))
}

class FullViewModel: FullViewModelProtocol {
    let networkService = NetworkService.shared
    
    func signUp(params: [String : Any], completion: @escaping ((SuccessFailure) -> Void)) {
        let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        guard let data = data else { return }
        networkService.sendRequest(urlRequest: AuthRouter.fullSingUp(data: data).createURLRequest(), successModel: FailureModel.self) { result in
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
