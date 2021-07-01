//
//  WeatherViewModel.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import Foundation

// MARK: - ViewModel
struct WeatherViewModel {
    let weather: Weather
    
    var city: String {
        return self.weather.title
    }
    
    var stateName: String {
        return self.weather.consolidatedWeather[0].weatherStateName
    }
    
    var stateAbbr: String {
        return self.weather.consolidatedWeather[0].weatherStateAbbr
    }
    
    var temp: Float {
        return self.weather.consolidatedWeather[0].theTemp
    }
    
    var humidity: Int {
        return self.weather.consolidatedWeather[0].humidity
    }
    
    var speed: Float {
        return self.weather.consolidatedWeather[0].windSpeed
    }
    
    var consolidatedWeather: [ConsolidatedWeather] {
        return self.weather.consolidatedWeather
    }
}

