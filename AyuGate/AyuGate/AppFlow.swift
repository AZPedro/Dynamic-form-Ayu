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

final class AppFlow: NSObject, FormStepFlowControllerDelegate {

    static var shared: AppFlow = AppFlow()
    
    private lazy var nav = UINavigationController()

    
    private lazy var loginFlow: LoginFlowController = {
        let flow = LoginFlowController()
        return flow
    }()
    
    private lazy var onboardingFlow: OnboardingFlowController = {
        let flow = OnboardingFlowController()
        return flow
    }()
    
    private lazy var messageSection: MessageSection = {
        return MessageSection(buttonTitle: "Abrir MEI", messageText: "Verificamos que agora você já pode ser MEI", sectionImage: Images.womanReading)
    }()

    func flow() -> UINavigationController {
        nav.isNavigationBarHidden = true
        
//        nav.viewControllers = [FormStepFlowController(dependencies: formDependencies)]
//        if SessionManager.shared.isUserLoged {
//            nav.viewControllers = [HomeFlowController()]
//        } else {  
//        nav.viewControllers = [loginFlow]
//        nav.viewControllers = [onboardingFlow]
        nav.viewControllers = [OnboardingMessageViewController(section: messageSection)]
        
        
//        }
        return nav
    }

    func formStepFlowControllerDelegateDidFinish() {
        // show wallet home
    }
}

struct FormDependence: FormDependencies {
    var formSectionDependence: [FormSection]
    var stepDependence: StepProtocol
}

struct CPFFormDepencies: FormDependencies {
    var formLayoutDependence: FormLayout
    var formSectionDependence: [FormSection]
    var stepDependence: StepProtocol
}

struct Section: FormSection {
    var sectionImage: UIImage? = Images.womanWithComputer
    var masks: [MaskField]
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
