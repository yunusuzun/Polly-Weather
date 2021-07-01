//
//  Extension+UIView.swift
//  Polly Weather
//
//  Created by Yunus Uzun on 30.06.2021.
//

import UIKit

// MARK: - View corner radius
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
