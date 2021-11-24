//
//  Location.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import Foundation

struct Location: Codable {
    
    let name: String?
    let lat: Decimal
    let lon: Decimal
        
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case lat = "lat"
        case lon = "long"
    }
}
