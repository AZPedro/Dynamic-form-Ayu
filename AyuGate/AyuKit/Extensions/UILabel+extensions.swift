//
//  UILabel+extensions.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

extension UILabel {
    @discardableResult public func lines(_ lineCount: Int=1) -> Self {
        numberOfLines = lineCount
        return self
    }

    @discardableResult public func text(_ text: String) -> Self {
        self.text = text
        return self
    }

    @discardableResult public func textColour(_ colour: UIColor) -> Self {
        self.textColor = colour
        return self
    }

    @discardableResult public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult public func translatesAutoresizingMaskIntoConstraints(_ value: Bool) -> Self {
        translatesAutoresizingMaskIntoConstraints = value
        return self
    }
}
