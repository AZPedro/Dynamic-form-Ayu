//
//  UIColor+extensions.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// colors
    static var error = UIColor.hexStringToUIColor(hex: "#FF0000")
    static var black = UIColor.hexStringToUIColor(hex: "#000000")
    static var blackSecondary = UIColor.hexStringToUIColor(hex: "#000000").withAlphaComponent(0.5)
    static var grayPrimary = UIColor.hexStringToUIColor(hex: "#7C7C7C")
    static var graySecondary = UIColor.hexStringToUIColor(hex: "#B9B9B9")
    static var white = UIColor.hexStringToUIColor(hex: "#FFFFFF")
    static var yellowPrimary = UIColor.hexStringToUIColor(hex: "#EFEC4E")
    static var yellowSecondary = UIColor.hexStringToUIColor(hex: "#EAEA64")
    static var yellowTerciary = UIColor.hexStringToUIColor(hex: "#C98300")
    static var redSecondary = UIColor.hexStringToUIColor(hex: "#A31A1A")
    static var greenPrimary = UIColor.hexStringToUIColor(hex: "#147914")
    
    /// functions
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
