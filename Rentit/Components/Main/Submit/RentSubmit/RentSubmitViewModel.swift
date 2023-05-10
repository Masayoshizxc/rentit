//
//  RentSubmitViewModel.swift
//  Rentit
//
//  Created Eldiiar on 12/11/22.
//

import Foundation
import Alamofire

protocol RentSubmitViewModelProtocol {
    func postProduct(params: [String : Any], attributes: [Int: Any], imagesData: [Data], completion: @escaping ((SuccessFailure) -> Void))
}

class RentSubmitViewModel: RentSubmitViewModelProtocol {
    let networkService = NetworkService.shared
    let userDefaults = UserDefaultsService.shared
    
    func postProduct(params: [String : Any], attributes: [Int: Any], imagesData: [Data], completion: @escaping ((SuccessFailure) -> Void)) {
        var attr = [[String:Any]]()
        
        for (key, value) in attributes {
            attr.append(["value" : value,
                         "attributeId" : key])
            
        }
        var parameters = params
        
        parameters["userId"] = userDefaults.getUserId()
        parameters["attributeRequestList"] = attr
        
        print(parameters)
        
        let data = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        guard let data = data else { return }
        networkService.sendRequest(urlRequest: ProductRouter.postProduct(data: data).createURLRequest(), successModel: Product.self) { result in
            switch result {
            case .success(let model):
                print(model)
                let userDefaults = UserDefaultsService.shared
                let header = HTTPHeader(name: "Authorization", value: "Bearer \(userDefaults.getByKey(key: .access))")
                let params = [
                    "productId" : String(model.id ?? 0)
                ]
                // swiftlint:disable all
                AF.upload(multipartFormData: { multipartFormData in
                    for i in 0..<imagesData.count {
                        multipartFormData.append(imagesData[i], withName: "file", fileName: "photo\(i).jpg" , mimeType: "image/jpeg")
                    }
                    for (key, value) in params {
                        print(key, value)
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }, to: "http://128.199.30.62:8080/product/save-image/\(model.id ?? 0)", method: .post, headers: [header])
                .responseDecodable(of: FailureModel.self) { response in
                    debugPrint(response)
                }
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
