//
//  GooglePlacesManager.swift
//  Rentit
//
//  Created by Eldiiar on 3/12/22.
//

import Foundation
import GooglePlaces

struct Place {
    let name: String
    let identifier: String
}

final class GooglePlacesManager {
    static let shared = GooglePlacesManager()
    
    private let client = GMSPlacesClient.shared()
    
    private init() {}
    
    func findPlaces(query: String, completion: @escaping (Result<[Place], Error>) -> Void) {
        let filter = GMSAutocompleteFilter()
        //filter.types = ["geocode"]
        filter.countries = ["KG"]
        client.findAutocompletePredictions(
            fromQuery: query,
            filter: filter,
            sessionToken: nil) { results, error in
                guard let results = results, error  == nil else {
                    completion(.failure(error!))
                    return
                }
                let places: [Place] = results.compactMap {
                    Place(
                        name: $0.attributedFullText.string,
                        identifier: $0.placeID
                    )
                }
                completion(.success(places))
            }
    }
    
    func resolveLocation(for place: Place, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void) {
        client.fetchPlace(
            fromPlaceID: place.identifier,
            placeFields: .coordinate,
            sessionToken: nil) { result, error in
                guard let result = result, error == nil else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(result.coordinate))
            }
    }
}
