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
        var identifier: String = ""
        
        var keyboardType: FormFieldContent.Keyboard = .number
        var mask: String? = "000.000.000-00"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Cpf", title: "Insira seu CPF")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
//        var validatorQuery: String? = """
//        var validate = function(value) {
//            return value.search(/^\\d{3}\\.\\d{3}\\.\\d{3}\\-\\d{2}$/)
//        }
//        """
    }
    
    struct PasswordField: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .default
        var mask: String? = nil
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Senha", title: "Insira sua senha!")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
        var isSecurity: Bool = true
    }
    
    struct ConfirmPasswordField: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .default
        var mask: String? = nil
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Confirmar senha", title: "Insira sua senha!")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
        var isSecurity: Bool = true
    }
    
    struct NameField: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String? = nil
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Nome Completo", title: "Diga nos seu nome!")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct EmailField: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String? = nil
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "E-mail", title: "E-mail")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct BirthDayDate: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String? = "00 / 00 / 0000"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "dd / mm / aaaa", title: "Nascimento")
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct DocumentRG: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .numberPad
        var mask: String? = "00.000.000-0"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "RG", title: "Numero de RG", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct OrgaoEmissor: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String?
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Órgão", title: "Órgão Emissor", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct UF: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .namePhonePad
        var mask: String?
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "UF", title: "UF", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
    
    struct DocumentRGDate: MaskField {
        var identifier: String = ""
        var keyboardType: UIKeyboardType = .numberPad
        var mask: String? = "00 / 00 / 0000"
        var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "dd / mm / aaaa", title: "Data de emissão", spacingAfterTitle: 5)
        var fieldType: FormFieldContent.FieldType = .text
        var validatorQuery: String?
    }
}
