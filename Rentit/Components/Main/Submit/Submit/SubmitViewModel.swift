//
//  SubmitViewModel.swift
//  Rentit
//
//  Created Eldiiar on 10/11/22.
//

import Foundation

protocol SubmitViewModelProtocol {
    func getCategory(completion: @escaping ((SuccessFailure) -> Void))
    func getSubCategory(id: Int, completion: @escaping ((SuccessFailure) -> Void))
    
    var categories: [Category] { get }
}

class SubmitViewModel: SubmitViewModelProtocol {
    let networkService = NetworkService.shared
    
    var categories = [Category]()
    
    func getCategory(completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: CategoryRouter.getCategory.createURLRequest(), successModel: [Category].self) { result in
            switch result {
            case .success(let model):
                for category in model {
                    if category.parentCategory == nil {
                        self.categories.append(category)
                    }
                }
                print(self.categories)
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
    
    func getSubCategory(id: Int, completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: CategoryRouter.getSubCategory(id: id).createURLRequest(), successModel: [Category].self) { result in
            switch result {
            case .success(let model):
                self.categories = model
                print(self.categories)
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
