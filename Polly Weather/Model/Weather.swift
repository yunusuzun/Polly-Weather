//
//  Weather.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable {
    let consolidatedWeather: [ConsolidatedWeather]
    let title: String
    let woeid: Int
    let lattLong, timezone: String

    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case title
        case woeid
        case lattLong = "latt_long"
        case timezone
    }
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Decodable {
    let weatherStateName, weatherStateAbbr: String
    let applicableDate: String
    let theTemp, windSpeed: Float
    let humidity: Int
    let visibility: Float
    let predictability: Int

    enum CodingKeys: String, CodingKey {
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case applicableDate = "applicable_date"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case humidity, visibility, predictability
    }
}
