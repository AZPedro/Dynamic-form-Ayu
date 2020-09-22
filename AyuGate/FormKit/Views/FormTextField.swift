//
//  FormTextField.swift
//  FormKit
//
//  Created by Pedro Azevedo on 18/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol FormSection {
    var masks: [MaskField] { get set }
    var sectionImage: UIImage? { get set }
    var sectionImageURL: String? { get set }
    var sectionTitle: String? { get set }
    var layout: FormLayout? { get set }
    var imagePosition: UIStackView.Alignment { get set }
    var imageBorderSpace: CGFloat { get set }
}

extension FormSection {    
    public var imagePosition: UIStackView.Alignment {
        get {
            return .leading
        }
        set {
            
        }
    }
    
    public var imageBorderSpace: CGFloat {
        get {
            switch imagePosition {
            case .trailing:
                return -10
            default:
                return 10
            }
        }
        set {
            
        }
    }
    
    public var sectionTitle: String? {
        get {
            return nil
        }
        set {
            
        }
    }
}

public protocol OnboardingFormSection: FormSection {
    var messageText: String { get set }
    var buttonTitle: String { get set }
}

extension OnboardingFormSection {
    public var buttonTitle: String {
        get {
            return "Avançar"
        }
        set {
            
        }
    }
}

public protocol LoginFormSectionProtocol: FormSection { }

extension OnboardingFormSection {
    public var masks: [MaskField] {
        get {
           return []
        }
        set {
            
        }
    }
}

public protocol MaskField {
    var mask: String? { get set }
    var keyboardType: FormFieldContent.Keyboard { get }
    var validatorQuery: String? { get set }
    var formModel: FormFieldContent.Model { get set }
    var fieldType: FormFieldContent.FieldType { get set }
    var isSecurity: Bool { get set }
}

extension MaskField {
    public var isSecurity: Bool {
        get {
            return false
        }
        set {
            
        }
    }
    
    public var fieldType: FormFieldContent.FieldType {
        get {
            return .text
        }
        
        set {
            
        }
    }
    
    public var keyboardType: FormFieldContent.Keyboard {
        get {
            return .default
        }
        
        set {
            
        }
    }
}
