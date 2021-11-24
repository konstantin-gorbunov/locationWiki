//
//  LiveLocationsDataProvider.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 24/11/2021.
//

import Foundation

struct LiveLocationsDataProvider: DataProvider {
    
    private enum Constants {
        static let url: URL? = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")
    }

    func fetchLocationList(_ completion: @escaping FetchLocationCompletion) {
        guard let url = Constants.url else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.resourceNotFound))
            }
            return
        }
        let task = URLSession.shared.locationsTask(with: url) { locations, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
            if let result = locations {
                DispatchQueue.main.async {
                    completion(.success(result.locations))
                }
            }
        }
        task.resume()
    }
}
