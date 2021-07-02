//
//  Polly_WeatherTests.swift
//  Polly WeatherTests
//
//  Created by Yunus Uzun on 30.06.2021.
//

import XCTest
@testable import Polly_Weather

class Polly_WeatherTests: XCTestCase {
    private var weather: Weather!
    private var city: City!
    private var cityViewModel: CityViewModel!
    private var weatherViewModel: WeatherViewModel!

    override func setUpWithError() throws {
        weather = Weather(consolidatedWeather: [ConsolidatedWeather(weatherStateName: "Showers", weatherStateAbbr: "c", applicableDate: "2021-07-02", theTemp: 12.4, windSpeed: 24.5, humidity: 53, visibility: 8.6, predictability: 73)], title: "London", woeid: 44418, lattLong: "51.506321,-0.12714", timezone: "Europe/London")
        
        city = City(distance: 10, title: "San Francisco", locationType: "City", woeid: 2487956, lattLong: "37.777119, -122.41964")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let weather = self.weather
        let city = self.city
        cityViewModel = CityViewModel(city: city!)
        weatherViewModel = WeatherViewModel(weather: weather!)
        XCTAssertEqual(weatherViewModel.city, "London")
        XCTAssertEqual(cityViewModel.title, "San Francisco")
    }
    
//    func weatherModelExample() throws {
//        let weather = self.weather
//        XCTAssertEqual(weather!.lattLong, "51.506321,-0.1")
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
