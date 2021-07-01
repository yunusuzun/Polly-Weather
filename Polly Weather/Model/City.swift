//
//  City.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import Foundation

// MARK: - City
struct City: Codable {
    let distance: Int
    let title: String
    let locationType: String
    let woeid: Int
    let lattLong: String

    enum CodingKeys: String, CodingKey {
        case distance, title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}
