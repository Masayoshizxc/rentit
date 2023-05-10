//
//  HalfRegViewModel.swift
//  Rentit
//
//  Created Eldiiar on 3/11/22.
//

import Foundation

protocol HalfRegViewModelProtocol {
    func signUp(params: [String : Any], completion: @escaping ((SuccessFailure) -> Void))
}

class HalfRegViewModel: HalfRegViewModelProtocol {
    
    let networkService = NetworkService.shared
    
    func signUp(params: [String : Any], completion: @escaping ((SuccessFailure) -> Void)) {
        let data = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        guard let data = data else { return }
        networkService.sendRequest(urlRequest: AuthRouter.signUp(data: data).createURLRequest(), successModel: LoginModel.self) { result in
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
