//
//  DetailViewController.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import UIKit
import Alamofire
import Kingfisher
import SkeletonView

final class DetailViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var todayImage: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var predictabilityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    private var weatherViewModel: WeatherViewModel!
    var city: CityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showSkeleton()
        view.backgroundColor = UIColor(red: 0.15, green: 0.17, blue: 0.23, alpha: 1.00)
        tableView.backgroundColor = UIColor(red: 0.15, green: 0.17, blue: 0.23, alpha: 1.00)
        weatherView.backgroundColor = UIColor(red: 0.20, green: 0.22, blue: 0.29, alpha: 1.00)
        overrideUserInterfaceStyle = .dark
        getWeather("https://www.metaweather.com/api/location/\(String(city!.woeid))")
        
    }
}

// MARK: - TableView
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherViewModel == nil ? 0 : self.weatherViewModel.consolidatedWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        cell.dateLabel.text = weatherViewModel.consolidatedWeather[indexPath.row].applicableDate.dayName
        cell.termLabel.text = "\(Float(round(weatherViewModel.consolidatedWeather[indexPath.row].theTemp)).clean)°"
        cell.weatherImage.kf.setImage(with: URL(string: "https://www.metaweather.com/static/img/weather/png/\(weatherViewModel.consolidatedWeather[indexPath.row].weatherStateAbbr).png"))
        cell.backgroundColor = UIColor(red: 0.15, green: 0.17, blue: 0.23, alpha: 1.00)
        return cell
    }
    
    
}

// MARK: - Data
extension DetailViewController {
    private func getWeather(_ url: String) {
        AF.request(url, method: .get).validate().responseDecodable(of: Weather.self) { (response) in
            guard let weather = response.value else { return }
            self.weatherViewModel = WeatherViewModel(weather: weather)
            DispatchQueue.main.async {
                self.view()
                self.hideSkeleton()
                self.tableView.reloadData()
            }
        }
    }
    
    private func view() {
        cityLabel.text = city!.title
        windLabel.text = "Wind Speed: \(Float(round(weatherViewModel.consolidatedWeather[0].windSpeed)).clean) km/h"
        humidityLabel.text = "Humidity: \(weatherViewModel.consolidatedWeather[0].humidity) %"
        visibilityLabel.text = "Visibility: \(Float(round(weatherViewModel.consolidatedWeather[0].visibility)).clean) km"
        predictabilityLabel.text = "Predictability: \(weatherViewModel.consolidatedWeather[0].predictability) %"
        tempLabel.text = "\(Float(round(weatherViewModel.consolidatedWeather[0].theTemp)).clean)°"
        todayImage.kf.setImage(with: URL(string: "https://www.metaweather.com/static/img/weather/png/\(weatherViewModel.consolidatedWeather[0].weatherStateAbbr).png"))
    }
}

// MARK: - Skeleton
extension DetailViewController {
    func showSkeleton() {
        [cityLabel, tableView, todayImage, windLabel, humidityLabel, visibilityLabel, predictabilityLabel, tempLabel].forEach { $0.showAnimatedSkeleton(usingColor: UIColor(red: 0.15, green: 0.17, blue: 0.23, alpha: 1.00))}
    }
    
    func hideSkeleton() {
        [cityLabel, tableView, todayImage, windLabel, humidityLabel, visibilityLabel, predictabilityLabel, tempLabel].forEach { $0.hideSkeleton()}
    }
}
