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
    let time, sunRise, sunSet, timezoneName: String
    let parent: Parent
    let title, locationType: String
    let woeid: Int
    let lattLong, timezone: String

    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case time
        case sunRise = "sun_rise"
        case sunSet = "sun_set"
        case timezoneName = "timezone_name"
        case parent, title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
        case timezone
    }
}

// MARK: - ConsolidatedWeather
struct ConsolidatedWeather: Decodable {
    let id: Int
    let weatherStateName, weatherStateAbbr, windDirectionCompass, created: String
    let applicableDate: String
    let theTemp, windSpeed: Float
    let humidity: Int
    let visibility: Float
    let predictability: Int

    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case weatherStateAbbr = "weather_state_abbr"
        case windDirectionCompass = "wind_direction_compass"
        case created
        case applicableDate = "applicable_date"
        case theTemp = "the_temp"
        case windSpeed = "wind_speed"
        case humidity, visibility, predictability
    }
}

// MARK: - Parent
struct Parent: Decodable {
    let title, locationType: String
    let woeid: Int
    let lattLong: String

    enum CodingKeys: String, CodingKey {
        case title
        case locationType = "location_type"
        case woeid
        case lattLong = "latt_long"
    }
}
