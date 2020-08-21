//
//  AppFlow.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

final class AppFlow: NSObject {
    
    static var shared: AppFlow = AppFlow()
    
    private lazy var nav = UINavigationController()
    
    private lazy var formDependencies: FormDependence = {
        return FormDependence(stepDependence: Step(numberOfSteps: 4, currentStep: 0))
    }()
    
    private lazy var cpfFormDependencies: CPFFormDepencies = {
        return CPFFormDepencies(stepDependence: Step(numberOfSteps: 1, currentStep: 0), maskDependence: CPFMask())
    }()

    func flow() -> UINavigationController {
        nav.isNavigationBarHidden = true
        
//        nav.viewControllers = [FormStepFlowController(dependencies: formDependencies)]
        if SessionManager.shared.isUserLoged {
            nav.viewControllers = [HomeFlowController()]
        } else {
//            nav.viewControllers = [FormStepFlowController(dependencies: formDependencies)]
            nav.viewControllers = [RegisterFlowController(dependencies: cpfFormDependencies)]
        }
        
        return nav
    }
}

struct FormDependence: FormDependencies {
    var stepDependence: StepProtocol
}

struct CPFFormDepencies: FormDependencies {
    var stepDependence: StepProtocol
    var maskDependence: MaskField
}

struct CPFMask: MaskField {
    var keyboardType: UIKeyboardType = .numberPad
    var mask: String = "000.000.000-00"
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
