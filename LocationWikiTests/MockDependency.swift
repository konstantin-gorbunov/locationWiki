//
//  MockDependency.swift
//  LocationWikiTests
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

@testable import LocationWiki

class MockDataProvider: DataProvider {

    var onFetch: ((DataProvider.FetchLocationCompletion) -> Void)?

    func fetchLocationList(_ completion: @escaping DataProvider.FetchLocationCompletion) {
        onFetch?(completion)
    }
}

class MockDependency: Dependency {
    
    let dataProvider: DataProvider = MockDataProvider()
}
