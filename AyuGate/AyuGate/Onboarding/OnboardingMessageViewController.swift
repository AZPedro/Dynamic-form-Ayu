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
import UIKit

class OnboardingMessageViewController: OnboardingStepCollectionViewCellContentController, AYUActionButtonDelegate, FormStepFlowControllerDelegate {

    let meiFormFlowSections: [FormSection] = [
        Section(masks: [Mock.NameField()]),
        Section(masks: [Mock.EmailField()]),
        Section(masks: [Mock.BirthDayDate()]),
        RGSection()
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

struct RGSection: FormSection {
    var masks: [MaskField] = [Mock.DocumentRG(), Mock.OrgaoEmissor(), Mock.UF(), Mock.DocumentRGDate()]
    var sectionImage: UIImage? = Images.womanWithDocument
    var imageBorderSpace: CGFloat = 0
}
