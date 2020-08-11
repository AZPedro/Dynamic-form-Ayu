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
    
    private func setup() {
        installChild(backgroundStepController)
        installChild(formStepCollectionController)
    }
}

