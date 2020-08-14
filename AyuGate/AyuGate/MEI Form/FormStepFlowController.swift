//
//  FormStepFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 03/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class FormStepFlowController: UIViewController, StepProtocol {
    
    var numberOfSteps: Int = 3
    var currentStep: Int = 0 {
        didSet {
            moveToStep(at: currentStep)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(numberOfSteps: numberOfSteps, currentStep: currentStep)
    }()
    
    lazy var formStepCollectionController: FormStepCollectionController = {
        let formCollection = FormStepCollectionController(numberOfSteps: numberOfSteps, currentStep: currentStep)
        formCollection.delegate = backgroundStepController
        return formCollection
    }()
    
    private lazy var stepBottomSegmentController: StepBottomSegmentController = {
        let stepBottomSegmentController = StepBottomSegmentController(delegate: self)
        return stepBottomSegmentController
    }()
    
    private func setup() {
        installChild(backgroundStepController)
        installChild(formStepCollectionController)
        installBottonSegment()
    }
    
    private func installBottonSegment() {
        addChild(stepBottomSegmentController)
        view.addSubview(stepBottomSegmentController.view)
        stepBottomSegmentController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            stepBottomSegmentController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stepBottomSegmentController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stepBottomSegmentController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func moveToStep(at position: Int) {
        formStepCollectionController.moveToStep(at: position)
        backgroundStepController.moveToStep(at: position)
    }
}

extension FormStepFlowController: StepBottomSegmentControllerDelegate {

    func stepBottomSegmentControllerDelegate(didBack: StepBottomSegmentController) {
        guard currentStep > 0 else { return }
        currentStep = currentStep-1
    }
    
    func stepBottomSegmentControllerDelegate(didNext: StepBottomSegmentController) {
        guard currentStep < numberOfSteps else { return }
        currentStep = currentStep+1
    }
}
