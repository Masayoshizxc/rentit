//
//  ProfileViewModel.swift
//  Rentit
//
//  Created Eldiiar on 13/11/22.
//

import Foundation

protocol ProfileViewModelProtocol {
    func getUser(completion: @escaping ((SuccessFailure) -> Void))
    func getMyProducts(completion: @escaping ((SuccessFailure) -> Void))
    
    var user: User? { get }
    var myProducts: [MyProducts] { get }
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    var user: User?
    var myProducts = [MyProducts]()
    
    let networkService = NetworkService.shared
    
    func getUser(completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: ProfileeRouter.getUser.createURLRequest(), successModel: User.self) { result in
            switch result {
            case .success(let model):
                print(model)
                self.user = model
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
    
    func getMyProducts(completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: ProfileeRouter.getMyProducts.createURLRequest(), successModel: [MyProducts].self) { result in
            switch result {
            case .success(let model):
                print(model)
                self.myProducts = model
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
