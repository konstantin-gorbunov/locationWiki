//
//  LocationListViewModel.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

struct LocationListViewModel {
    /// List of Locations
    let locations: [Location]
    
    init(_ locations: [Location]) {
        self.locations = locations
    }
}
