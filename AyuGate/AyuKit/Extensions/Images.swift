//
//  Images.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public final class Images {
    public static let ayuYbackground = UIImage(named: "ayuYbackground")!
    public static let womanWithComputer = UIImage(named: "WomanWithComputer")!
    public static let womanWithDocument = UIImage(named: "WomanWithDocument")!
    public static let manWalkingWithCellPhone = UIImage(named: "ManWalkingWithCellPhone")!
    public static let womanReading = UIImage(named: "WomanReading")!
    public static let checkMarck = UIImage(named: "checkmark")!
    public static let uploadIcon = UIImage(named: "uploadIcon")!
    public static let formStatusCheck = UIImage(named: "formStatusCheck")!
    public static let validatingIcon = UIImage(named: "validatingIcon")!
    public static let warningIcon = UIImage(named: "warningIcon")!
}

public extension UIImage {
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
}
