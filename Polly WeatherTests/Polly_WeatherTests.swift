//
//  Polly_WeatherTests.swift
//  Polly WeatherTests
//
//  Created by Yunus Uzun on 30.06.2021.
//

import XCTest
@testable import Polly_Weather

class Polly_WeatherTests: XCTestCase {
    var weather: Weather!
    private var weatherViewModel: WeatherViewModel!

    override func setUpWithError() throws {
        weather = Weather(consolidatedWeather: [ConsolidatedWeather(id: 5, weatherStateName: "Showers", weatherStateAbbr: "c", windDirectionCompass: "SSW", created: "2021-07-02T06:32:01.461705Z", applicableDate: "2021-07-02", theTemp: 12.4, windSpeed: 24.5, humidity: 53, visibility: 8.6, predictability: 73)], time: "2021-07-02T04:48:25.965685+01:00", sunRise: "2021-07-02T04:48:25.965685+01:00", sunSet: "2021-07-02T04:48:25.965685+01:00", timezoneName: "LMT", parent: Parent(title: "England", locationType: "Region / State / Province", woeid: 24554868, lattLong: "52.883560,-1.974060"), title: "London", locationType: "City", woeid: 44418, lattLong: "51.506321,-0.12714", timezone: "Europe/London")
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let weather = self.weather
        weatherViewModel = WeatherViewModel(weather: weather!)
        XCTAssertEqual(weatherViewModel.city, "London")
    }
    
    func weatherModelExample() throws {
        let weather = self.weather
        XCTAssertEqual(weather!.lattLong, "51.506321,-0.1")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
