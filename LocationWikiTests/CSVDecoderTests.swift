//
//  CSVDecoderTests.swift
//  LocationWikiTests
//
//  Created by Kostiantyn Gorbunov on 22/11/2021.
//

import XCTest
@testable import LocationWiki

class CSVDecoderTests: XCTestCase {

    func testDecoding() {
        let data = """
        name,age,city,postcode,birthplace
        _why,45,Bath,BA15NF,
        """
        let decoder = CSVDecoder()
        do {
            let customer = try decoder.decode(Customer.self, from: data)
            XCTAssertEqual(customer.name, "_why")
            XCTAssertEqual(customer.age, 45)
            XCTAssertEqual(customer.city, "Bath")
            XCTAssertEqual(customer.postcode, "BA15NF")
            XCTAssertNil(customer.birthplace)
        }
        catch {
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
    
    func testDecodingArray() {
        let data = """
        name,age,city,postcode,birthplace
        _why,45,Bath,,London
        Red,15,Bath,BA15NF,London
        """
        let decoder = CSVDecoder()
        do {
            let customers = try decoder.decode([Customer].self, from: data)
            XCTAssertEqual(customers.count, 2)
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testKeyNotExisting() {
        let data = """
        error,age,city,postcode,birthplace
        _why,45,Bath,BA15NF,London
        """
        let decoder = CSVDecoder()
        do {
            _ = try decoder.decode(Customer.self, from: data)
            XCTFail()
        }
        catch let error as DecodingError {
            switch error {
            case .keyNotFound(let key, _):
                XCTAssertEqual(key.stringValue, "name")
            default:
                XCTFail("Incorrect error \(error)")
            }
        }
        catch {
            XCTFail("Incorrect error \(error)")
        }
    }
    
    func testLocationDecoding() {
        let data = """
        "lat","lon"
        "52.0716335","4.2398289"
        """
        let decoder = CSVDecoder()
        do {
            let location = try decoder.decode(Location.self, from: data)
            XCTAssertEqual(location.lat, "52.0716335")
            XCTAssertEqual(location.lon, "4.2398289")
        }
        catch {
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
}

// MARK: Customer

fileprivate struct Customer: Decodable {
    let name: String
    let age: Int
    let city: String
    let postcode: String?
    let birthplace: String?
    
    // MARK: Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case city
        case postcode
        case birthplace
    }
}
