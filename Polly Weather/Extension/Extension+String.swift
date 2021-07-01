//
//  Extension+String.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 1.07.2021.
//

import Foundation

// MARK: - Date to day name
extension String {
    var dayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self)!
        dateFormatter.dateFormat = "EEEE"
        let name = dateFormatter.string(from: date)
        return name
    }
}
