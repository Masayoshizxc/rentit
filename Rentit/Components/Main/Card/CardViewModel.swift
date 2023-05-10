//
//  CardViewModel.swift
//  Rentit
//
//  Created Eldiiar on 16/11/22.
//

import Foundation

protocol CardViewModelProtocol {
    func getProduct(id: Int, completion: @escaping ((SuccessFailure) -> Void))
    
    var product: Product? { get }
}

class CardViewModel: CardViewModelProtocol {
    let networkService = NetworkService.shared
    
    var product: Product?
    
    func getProduct(id: Int, completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: ProductRouter.getProductById(id: id).createURLRequest(), successModel: Product.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.product = model
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
