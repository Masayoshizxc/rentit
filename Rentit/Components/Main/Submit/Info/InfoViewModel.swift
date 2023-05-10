//
//  InfoViewModel.swift
//  Rentit
//
//  Created Eldiiar on 11/11/22.
//

import Foundation

protocol InfoViewModelProtocol {
    func getAttributes(id: Int, completion: @escaping ((SuccessFailure) -> Void))
    
    var attributes: [Attributes] { get }
}

class InfoViewModel: InfoViewModelProtocol {
    let networkService = NetworkService.shared
    
    var attributes = [Attributes]()
    
    func getAttributes(id: Int, completion: @escaping ((SuccessFailure) -> Void)) {
        networkService.sendRequest(urlRequest: AttributesRouter.getAttributes(id: id).createURLRequest(), successModel: [Attributes].self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.attributes = model
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
