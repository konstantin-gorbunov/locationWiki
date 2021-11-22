//
//  Location.swift
//  LocationWiki
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import Foundation

struct Location: Decodable {
    
    let lat: String
    let lon: String
        
    enum CodingKeys: String, CodingKey {
        case lat = "\"lat\""
        case lon = "\"lon\""
    }
}
