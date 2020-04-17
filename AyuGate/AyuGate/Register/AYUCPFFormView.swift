//
//  AYUCPFFormView.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUCPFFormView: AYUTextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildUI()
    }
    
    var value: String? {
        return textField.text?.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
    }
    
    struct Constants {
        static let maxDigits = 13
        static let _points = [11]
        static let rangePoints = [3,7]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        textField.keyboardType = .numberPad
        placeHolder.text = "CPF"
        titleLabel.text = "Entrar com CPF"
        errorLabel.text = "Não foi possível encontrar o CPF inserido"
        textField.delegate = self
    }
    
    var validationHandler: ((Bool) -> Void)?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard !string.isEmpty else {
            return true
        }

        guard let digtsCount = textField.text?.count, digtsCount <= Constants.maxDigits else {
            return false
        }

        if Constants.rangePoints.contains(range.location) {
            textField.text?.append(".")
        } else if Constants._points.contains(range.location) {
            textField.text?.append("-")
        }

        return true
    }
    
    override func textDidChanged(_ sender: UITextField) {
        validationHandler?(false)
        guard let textDigits = sender.text, textDigits.count == 14 else {
            return
        }
        
        guard let cpfValue = value else {
            updateState(state: .failed)
            return
        }
        
        if !cpfValue.isCPF {
            validationHandler?(false)
            updateState(state: .failed)
        } else {
            validationHandler?(true)
            updateState(state: .input)
        }
    }
}
