//
//  LocalJSONLocationsDataProvider.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 24/11/2021.
//

import Foundation

struct LocalJSONLocationsDataProvider: DataProvider {

    private let queue = DispatchQueue(label: "LocalJSONLocationsDataProvider")

    // Completion block will be called on main queue
    func fetchLocationList(_ completion: @escaping FetchLocationCompletion) {
        guard let path = Bundle.main.url(forResource: "locations", withExtension: "json") else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.resourceNotFound))
            }
            return
        }
        queue.async {
            do {
                let jsonData = try Data(contentsOf: path)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let result = try decoder.decode(Locations.self, from: jsonData)
                DispatchQueue.main.async {
                    completion(.success(result.locations))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
        }
    }
}
