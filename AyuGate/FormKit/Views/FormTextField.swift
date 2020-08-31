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
    var layout: FormLayout? { get set }
    var imagePosition: NSTextAlignment { get set }
    var imageBorderSpace: CGFloat { get set }
}

extension FormSection {
    public var layout: FormLayout? {
        get {
            return nil
        }
        
        set {
            
        }
    }
    
    public var imagePosition: NSTextAlignment {
        get {
            return .left
        }
        
        set {
            
        }
    }
    
    public var imageBorderSpace: CGFloat {
        get {
            switch imagePosition {
            case .right:
                return -10
            default:
                return 10
            }
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
    var keyboardType: UIKeyboardType { get }
    var validatorQuery: String? { get set }
    var formModel: FormFieldContent.Model { get set }
    var fieldType: FormFieldContent.FieldType { get set }
}
