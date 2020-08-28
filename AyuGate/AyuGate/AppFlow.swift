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
    
    let meiFormFlowSections: [FormSection] = [
        CPFSection(masks: [Mock.NameField()]),
        CPFSection(masks: [Mock.EmailField()]),
        CPFSection(masks: [Mock.BirthDayDate()]),
        CPFSection(sectionImage: nil, masks: [Mock.DocumentRG(), Mock.OrgaoEmissor(), Mock.UF(), Mock.DocumentRGDate()])
    ]
    
    let meiFormFlowUncompletedSections: [FormSection] = [
        CPFSection(masks: [Mock.BirthDayDate()]),
        CPFSection(sectionImage: nil, masks: [Mock.DocumentRG(), Mock.OrgaoEmissor(), Mock.UF(), Mock.DocumentRGDate()])
    ]
    
    private lazy var meiFormFlowDependencies: CPFFormDepencies = {
        return CPFFormDepencies(formSectionDependence: meiFormFlowSections ,stepDependence: Step(numberOfSteps: meiFormFlowSections.count-1, currentStep: 0))
    }()
    
    private lazy var meiFormFlowUnCompletedDependencies: CPFFormDepencies = {
        return CPFFormDepencies(formSectionDependence: meiFormFlowUncompletedSections ,stepDependence: Step(numberOfSteps: meiFormFlowUncompletedSections.count-1, currentStep: 0))
    }()
    
    // Formulario para MEI vazio
    private lazy var meiFormFlow: FormStepFlowController = {
        let flow = FormStepFlowController(dependencies: meiFormFlowDependencies)
        flow.delegate = self
        return flow
    }()
    
    // Formulário com campos que estão faltando
    private lazy var meiFormUnCompletedFlow: FormStepFlowController = {
        let flow = FormStepFlowController(dependencies: meiFormFlowUnCompletedDependencies)
        flow.delegate = self
        return flow
    }()
    
    private lazy var mockedLoginScreen: LoginScreenController = {
        let flow = LoginScreenController(dependence: meiFormFlowDependencies.stepDependence)
        return flow
    }()

    func flow() -> UINavigationController {
        nav.isNavigationBarHidden = true
        
//        nav.viewControllers = [FormStepFlowController(dependencies: formDependencies)]
//        if SessionManager.shared.isUserLoged {
//            nav.viewControllers = [HomeFlowController()]
//        } else {  
        nav.viewControllers = [mockedLoginScreen]
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
    var formSectionDependence: [FormSection]
    var stepDependence: StepProtocol
}

struct CPFSection: FormSection {
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
