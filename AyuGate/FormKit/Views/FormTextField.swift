//
//  FormTextField.swift
//  FormKit
//
//  Created by Pedro Azevedo on 18/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol MaskField {
    var mask: String { get set }
    var limit: Int { get set }
}

protocol TextFieldMaskAble {
    func mask(field: UITextField) -> String
    func unMask(field: UITextField) -> String
}

public class FormTextField: UITextField, TextFieldMaskAble {
    
    var maskField: MaskField
    
    init(maskField: MaskField) {
        self.maskField = maskField
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func mask(field: UITextField) -> String {
        return ""
    }
    
    func unMask(field: UITextField) -> String {
        return ""
    }
}
