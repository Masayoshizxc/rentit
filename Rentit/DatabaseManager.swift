//
//  DatabaseManager.swift
//  Rentit
//
//  Created by Eldiiar on 4/12/22.
//

import Foundation

import FirebaseStorage

final class StorageManger {
    static let shared = StorageManger()
    
    let storage = Storage.storage().reference()
    
    func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        reference.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(url))
            
        }
    }
    
    func uploadMessagePicture(with data: Data,
                              fileName: String,
                              completion: @escaping (Result<String, Error>) -> Void) {
        storage.child("message_images/\(fileName)").putData(data, metadata: nil) { [weak self] metadata, error in
            guard error == nil else {
                print("Failed to upload data into the firebase")
                completion(.failure(error!))
                return
            }
            self?.storage.child("message_images/\(fileName)").downloadURL { url, error in
                guard let url = url else {
                    print("Failed to download url data")
                    completion(.failure(error!))
                    return
                }
                let urlString = url.absoluteString
                completion(.success(urlString))
            }
        }
    }
}
