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
    public static var error = UIColor.hexStringToUIColor(hex: "#FF0000")
    public static var blackPrimary = UIColor.hexStringToUIColor(hex: "#000000")
    public static var blackSecondary = UIColor.hexStringToUIColor(hex: "#000000").withAlphaComponent(0.5)
    public static var blackTerciary = UIColor.hexStringToUIColor(hex: "#535353")
    public static var grayPrimary = UIColor.hexStringToUIColor(hex: "#7C7C7C")
    public static var graySecondary = UIColor.hexStringToUIColor(hex: "#B9B9B9")
    public static var whitePlaceholder = UIColor.hexStringToUIColor(hex: "#FFFFFF").withAlphaComponent(0.38)
    public static var whiteSecondary = UIColor.hexStringToUIColor(hex: "#F8F8F8")
    public static var yellowPrimary = UIColor.hexStringToUIColor(hex: "#EFEC4E")
    public static var yellowSecondary = UIColor.hexStringToUIColor(hex: "#EAEA64")
    public static var yellowTerciary = UIColor.hexStringToUIColor(hex: "#C98300")
    public static var redSecondary = UIColor.hexStringToUIColor(hex: "#A31A1A")
    public static var greenPrimary = UIColor.hexStringToUIColor(hex: "#147914")
    
    //FormColors
    
    public static var formBackgroundColor = UIColor.hexStringToUIColor(hex: "#1D1F24")
    public static var formBackgroundSecondaryColor = UIColor.hexStringToUIColor(hex: "#333333")
    public static var textPlaceholderColor = UIColor.hexStringToUIColor(hex: "#333333").withAlphaComponent(0.5)
    
    
    /// functions
    public static func hexStringToUIColor (hex:String) -> UIColor {
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
