//
//  OnboardingMessageViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 29/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation
import AyuKit
import FormKit

class OnboardingMessageViewController: OnboardingStepCollectionViewCellContentController, AYUActionButtonDelegate, FormStepFlowControllerDelegate {

    let meiFormFlowSections: [FormSection] = [
        CPFSection(masks: [Mock.NameField()]),
        CPFSection(masks: [Mock.EmailField()]),
        CPFSection(masks: [Mock.BirthDayDate()]),
        CPFSection(sectionImage: nil, masks: [Mock.DocumentRG(), Mock.OrgaoEmissor(), Mock.UF(), Mock.DocumentRGDate()])
    ]
    
    struct MeiFormLayout: FormLayout {
        var isScrollEnabled: Bool = false
        var shouldShowStepBottom: Bool = true
    }
    
    private lazy var meiFormFlowDependencies: CPFFormDepencies = {
        return CPFFormDepencies(formLayoutDependence: MeiFormLayout(), formSectionDependence: meiFormFlowSections ,stepDependence: Step(numberOfSteps: meiFormFlowSections.count-1, currentStep: 0))
    }()
    
    // Formulario para MEI vazio
    private lazy var meiFormFlow: FormStepFlowController<FormStepCollectionViewCell> = {
        let flow = FormStepFlowController<FormStepCollectionViewCell>(dependencies: meiFormFlowDependencies)
        flow.modalPresentationStyle = .fullScreen
        flow.delegate = self
        return flow
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        actionButton.isHidden = false
        actionButton.delegate = self
    }
    
    func actionButtonDelegateDidTouch(_ sender: Any) {
        present(meiFormFlow, animated: true, completion: nil)
    }
    
    func formStepFlowControllerDelegateDidFinish() {
        
    }
}
