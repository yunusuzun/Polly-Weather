//
//  CityViewModel.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import Foundation

// MARK: - ViewModel
struct CityViewModel {
    let city: City
    
    var distance: Int {
        return self.city.distance
    }
    
    var title: String {
        return self.city.title
    }
    
    var locationType: String {
        return self.city.locationType
    }
    
    var woeid: Int {
        return self.city.woeid
    }
    
    var lattLong: String {
        return self.city.lattLong
    }
}

// MARK: - ListViewModel
struct CityListViewModel {
    let cityList: [City]
    
    func numberOfRowsInSection() -> Int {
         return self.cityList.count
     }
     
     func cityAtIndex(_ index: Int) -> CityViewModel {
         let city = self.cityList[index]
         return CityViewModel(city: city)
     }
}
