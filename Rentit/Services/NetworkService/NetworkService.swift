//
//  NetworkService.swift
//  cms
//
//  Created by Eldiiar on 4/10/22.
//


import Foundation
import Alamofire

class NetworkService {
    
    static let shared = NetworkService()
    
    func sendRequest<T: Decodable>(
        urlRequest: URLRequest,
        successModel: T.Type,
        completion: @escaping (ProResult<T>) -> Void
    ) {
        AF.request(urlRequest).responseDecodable(of: successModel.self) { [weak self] response in
            guard let self = self else {
                debugPrint(#function, "Your View Class is dead!")
                return
            }
            
            let queue = DispatchQueue.main

            let data = response.data
                        
            if let error = self.validateResponse(data: data, response: response.response, error: response.error) {
                if case NetworkErrors.badRequest = error,
                   let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.badRequest(model))
                } else if case NetworkErrors.notFound = error,
                          let model = self.transformFromJSON(data: data, objectType: FailureModel.self) {
                    completion(.notFound(model))
                } else {
                    completion(.failure("Упс, что-то пошло не так)  \(error)"))
                }
            } else if let successModel = self.transformFromJSON(data: data, objectType: T.self) {
                queue.async {
                    completion(.success(successModel))
                }
            }
            
        }
    }
    
    private func validateResponse(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        if let err = error {
            return err
        }
        guard let httpResponse = response as? HTTPURLResponse else {
            return URLError(.badServerResponse)
        }
        switch httpResponse.statusCode {
        case 200...210:
            return nil
        case 401:
            return NetworkErrors.unauthorized
        case 405:
            return NetworkErrors.forbidden
        case StatusCode.badRequest.code:
            return NetworkErrors.badRequest
        case StatusCode.forbidden.code:
            return NetworkErrors.forbidden
        case StatusCode.badRequest.code:
            return NetworkErrors.badRequest
        case StatusCode.forbidden.code:
            return NetworkErrors.forbidden
        case StatusCode.notFound.code:
            return NetworkErrors.notFound
        default:
            return nil
        }
    }
    
    private func transformFromJSON<T: Decodable>(data: Data?, objectType: T.Type) -> T? {
        guard let data = data else {return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    } 
} 
