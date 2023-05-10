//
//  AuthViewModel.swift
//  Rentit
//
//  Created Eldiiar on 15/10/22.
//

import Foundation

enum SuccessFailure {
    case success
    case failure
}

protocol LoginViewModelProtocol {
    func login(email: String, password: String, completion: @escaping ((SuccessFailure) -> Void))
}

class LoginViewModel: LoginViewModelProtocol {
    
    let networkService = NetworkService.shared
    
    func login(email: String, password: String, completion: @escaping ((SuccessFailure) -> Void)) {
        let parameters: [String : Any] = [
            "username" : email,
            "password" : password
        ]
        let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        guard let data = data else { return }
        networkService.sendRequest(urlRequest: AuthRouter.signIn(data: data).createURLRequest(), successModel: LoginModel.self) { result in
            switch result {
            case .success(let model):
                print(model)
                let userDefaults = UserDefaultsService.shared
                userDefaults.saveAccessToken(name: model.token)
                userDefaults.saveUserId(id: model.id ?? 0)
                print(userDefaults.getUserId())
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
