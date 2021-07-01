//
//  Extension+Float.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import Foundation

// MARK: - Hide zeros
extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
