//
//  DataProvider.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import Foundation

enum DataProviderError: Error {
    case resourceNotFound
    case parsingFailure(inner: Error)
}

protocol DataProvider {
    typealias FetchLocationResult = Result<[Location], Error>
    typealias FetchLocationCompletion = (FetchLocationResult) -> Void

    func fetchLocationList(_ completion: @escaping FetchLocationCompletion)
}
