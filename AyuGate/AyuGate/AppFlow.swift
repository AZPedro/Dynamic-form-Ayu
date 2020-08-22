//
//  AppFlow.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit
import AyuKit

final class AppFlow: NSObject {
    
    static var shared: AppFlow = AppFlow()
    
    private lazy var nav = UINavigationController()
    
    let cpfFormSections: [FormSection] = [
        CPFSection(masks: [ CPFMask(), CPFMask(), CPFMask()]),
        CPFSection(masks: [CPFMask() ])
    ]
    
    private lazy var cpfFormDependencies: CPFFormDepencies = {
        return CPFFormDepencies(formSectionDependence: cpfFormSections ,stepDependence: Step(numberOfSteps: cpfFormSections.count-1, currentStep: 0))
    }()
    
    private lazy var cpfFormFlow: FormStepFlowController = {
        return FormStepFlowController(dependencies: cpfFormDependencies)
    }()

    func flow() -> UINavigationController {
        nav.isNavigationBarHidden = true
        
//        nav.viewControllers = [FormStepFlowController(dependencies: formDependencies)]
        if SessionManager.shared.isUserLoged {
            nav.viewControllers = [HomeFlowController()]
        } else {
            nav.viewControllers = [cpfFormFlow]
//            nav.viewControllers = [RegisterFlowController(dependencies: cpfFormDependencies)]
        }

        return nav
    }
}

struct FormDependence: FormDependencies {
    var formSectionDependence: [FormSection]
    var stepDependence: StepProtocol
}

struct CPFFormDepencies: FormDependencies {
    var formSectionDependence: [FormSection]
    var stepDependence: StepProtocol
}

struct CPFSection: FormSection {
    var sectionImage: UIImage = Images.womanWithComputer
    var masks: [MaskField]
}

struct CPFMask: MaskField {
    var validatorQuery: String = """
    var validate = function(value) {
        return value.search(/^\\d{3}\\.\\d{3}\\.\\d{3}\\-\\d{2}$/)
    }
    """
    var keyboardType: UIKeyboardType = .numberPad
    var mask: String = "000.000.000-00"
    var formModel: FormFieldContent.Model = FormFieldContent.Model(placeholder: "Cpf", title: "Insira seu CPF")
}

struct Step: StepProtocol {
    
    var delegate: StepProtocolDelegate?
    var numberOfSteps: Int
    
    var currentStep: Int {
        didSet {
            delegate?.moveToStep(at: currentStep)
        }
    }
}
