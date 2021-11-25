//
//  LocationViewModel.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import Foundation

struct LocationViewModel {
    let location: Location?
    let borderSides: BorderLayer.Side
    let name: String
    let coordinate: String
    
    init(_ location: Location?, borderSides: BorderLayer.Side) {
        self.location = location
        self.borderSides = borderSides
        if let location = location {
            coordinate = "Lat: \(location.lat) Long: \(location.lon)"
        }
        else {
            coordinate = ""
        }
        name = location?.name ?? "No name"
    }
}

extension BorderLayer.Side {
    /// Return border sides for given index path
    static func border(at indexPath: IndexPath,
                       itemsInRow: Int = BaseCollectionViewController.Constants.itemsInRow) -> BorderLayer.Side {
        var result: BorderLayer.Side = [.bottom, .right]
        if indexPath.row < itemsInRow {
            result.insert(.top)
        }
        if indexPath.row % itemsInRow == 0 {
            result.insert([.left])
        }
        return result
    }
}
