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
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Cpf", title: "Insira seu CPF", errorMessage: "Cpf inserido é inválido")
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
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Senha", title: "Insira sua senha!", errorMessage: "Senha incorreta")
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
    
    struct BirthDayDate: MaskField {
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String? = "00 / 00 / 0000"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "dd / mm / aaaa", title: "Nascimento")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct DocumentRG: MaskField {
        var keyboardType: UIKeyboardType = .numberPad
        var mask: String? = "00.000.000-0"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "RG", title: "Numero de RG", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct OrgaoEmissor: MaskField {
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String?
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Órgão", title: "Órgão Emissor", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct UF: MaskField {
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String?
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "UF", title: "UF", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct DocumentRGDate: MaskField {
        var keyboardType: UIKeyboardType = .numberPad
        var mask: String? = "00 / 00 / 0000"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "dd / mm / aaaa", title: "Data de emissão", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
}
