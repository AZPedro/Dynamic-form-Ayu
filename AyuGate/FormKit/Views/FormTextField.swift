//
//  FormTextField.swift
//  FormKit
//
//  Created by Pedro Azevedo on 18/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol MaskField {
    var mask: String { get set }
    var keyboardType: UIKeyboardType { get }
}
