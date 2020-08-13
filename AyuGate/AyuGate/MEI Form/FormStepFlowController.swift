//
//  FormStepFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 03/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class FormStepFlowController: UIViewController {
    
    struct Constants {
        static let numberOfSteps = 5
        static let currentStep = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(numberOfSteps: Constants.numberOfSteps, currentStep: Constants.currentStep)
    }()
    
    lazy var formStepCollectionController: FormStepCollectionController = {
        let formCollection = FormStepCollectionController(numberOfSteps: Constants.numberOfSteps, currentStep: Constants.currentStep)
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
}

extension FormStepFlowController: StepBottomSegmentControllerDelegate {

    func stepBottomSegmentControllerDelegate(didBack: StepBottomSegmentController) {
        print("back")
    }
    
    func stepBottomSegmentControllerDelegate(didNext: StepBottomSegmentController) {
        print("nex")
    }
}
