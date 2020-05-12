//
//  PasswordValidationViewModel.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

class PasswordValidationViewModel {
    private let status: Int
    private let code: String
    private let validation: Validations
    
    init(model: Validation) {
        self.status = model.status
        self.code = model.code
        self.validation = Validations(rawValue: code) ?? .default
    }
    
    enum Validations: String {
        case invalidCredentials = "invalid_credentials"
        case `default` = "default"
    }
    
    var validationMessage: String {
        switch validation {
        case .invalidCredentials:
            return "Senha inválida"
        default:
            return "Error inesperado"
        }
    }
}
