//
//  WeatherViewController.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import UIKit
import Alamofire
import Kingfisher
import SkeletonView
import CoreLocation

final class WeatherViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var weatherViewModel: WeatherViewModel!
    private var cityListViewModel: CityListViewModel!
    private let locationManager = CLLocationManager()
    private var locationInfo = (latitute: "", longitude : "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        location()
        showSkeleton()
    }
}

// MARK: - Location
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationInfo.latitute = String(format: "%f", locations[0].coordinate.latitude)
        locationInfo.longitude = String(format: "%f", locations[0].coordinate.longitude)
        getCity(locationInfo.latitute, locationInfo.longitude)
        locationManager.stopUpdatingLocation()
    }
    
    func location() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationInfo.latitute == "" && locationInfo.longitude == "" {
            return
        } else {
            getCity(locationInfo.latitute, locationInfo.longitude)
        }
    }
}

// MARK: - CollectionView
extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cityListViewModel == nil ? 0 : self.cityListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as! CityCollectionViewCell
        let cityViewModel = self.cityListViewModel.cityAtIndex(indexPath.row)
        cell.cityLabel.text = cityViewModel.title
        cell.distanceLabel.text = "\(cityViewModel.distance / 1000) km"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            let selectedIndexPath = sender as? NSIndexPath
            let vc = segue.destination as! DetailViewController
            vc.city = self.cityListViewModel.cityAtIndex(selectedIndexPath!.row)
        }
    }
}

// MARK: - Data
extension WeatherViewController {
    func getWeather(_ woeid: Int) {
        AF.request("https://www.metaweather.com/api/location/\(String(woeid))", method: .get).validate().responseDecodable(of: Weather.self) { (response) in
            guard let weather = response.value else { return }
            self.weatherViewModel = WeatherViewModel(weather: weather)
            DispatchQueue.main.async {
                self.view(self.weatherViewModel)
            }
        }
    }
    
    private func getCity(_ latitute: String, _ longitude: String) {
        // Istanbul coordinate = 41,28
        AF.request("https://www.metaweather.com/api/location/search/?lattlong=\(latitute),\(longitude)", method: .get).validate().responseDecodable(of: [City].self) { (response) in
            guard let city = response.value else { return }
            self.cityListViewModel = CityListViewModel(cityList: city)
            self.getWeather(self.cityListViewModel.cityAtIndex(0).woeid)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func view(_ weatherViewModel: WeatherViewModel) {
        hideSkeleton()
        cityLabel.text = weatherViewModel.city
        stateLabel.text = weatherViewModel.stateName
        tempLabel.text = "\(Float(round(weatherViewModel.temp)).clean)°"
        speedLabel.text = "\(Float(round(weatherViewModel.speed)).clean) km/h"
        humidityLabel.text = "\(weatherViewModel.humidity) %"
        weatherImage.kf.setImage(with: URL(string: "https://www.metaweather.com/static/img/weather/png/\(weatherViewModel.stateAbbr).png"))
    }
}

// MARK: - Skeleton
extension WeatherViewController {
    func showSkeleton() {
        [cityLabel, stateLabel, tempLabel, tempLabel, speedLabel, humidityLabel, weatherImage, collectionView].forEach { $0.showAnimatedSkeleton(usingColor: UIColor.systemYellow)}
    }
    
    func hideSkeleton() {
        [cityLabel, stateLabel, tempLabel, tempLabel, speedLabel, humidityLabel, weatherImage, collectionView].forEach { $0.hideSkeleton()}
    }
}

