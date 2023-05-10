//
//  CompareViewModel.swift
//  Rentit
//
//  Created Eldiiar on 24/11/22.
//

import Foundation

protocol CompareViewModelProtocol {
    func getCompare(productIds: [Int], completion: @escaping ((SuccessFailure) -> Void))
    
    var product: [Product] { get }
}

class CompareViewModel: CompareViewModelProtocol {
    let networkService = NetworkService.shared
    
    var product = [Product]()
    
    func getCompare(productIds: [Int], completion: @escaping ((SuccessFailure) -> Void)) {
        let data = try? JSONSerialization.data(withJSONObject: productIds, options: .prettyPrinted)
        guard let data = data else { return }
        networkService.sendRequest(urlRequest: FavouritesRouter.getCompare(data: data).createURLRequest(), successModel: [Product].self) { result in
            switch result {
            case .success(let model):
                print(model)
                self.product = model
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
