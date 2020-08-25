//
//  Mock.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 24/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

public class Mock {
    
    /// CPF Field
    struct CPFField: MaskField {
        var keyboardType: UIKeyboardType = .numberPad
        var mask: String? = "000.000.000-00"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Cpf", title: "Insira seu CPF")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String? = """
        var validate = function(value) {
            return value.search(/^\\d{3}\\.\\d{3}\\.\\d{3}\\-\\d{2}$/)
        }
        """
    }
    
    struct PasswordField: MaskField {
        var keyboardType: UIKeyboardType = .default
        var mask: String? = nil
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Senha", title: "Insira sua senha!")
        var fieldType: FormFieldContent.FieldType = .security
        var validatorQuery: String?
    }
    
    struct NameField: MaskField {
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String? = nil
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Nome Completo", title: "Diga nos seu nome!")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct EmailField: MaskField {
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String? = nil
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "E-mail", title: "E-mail")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
}
