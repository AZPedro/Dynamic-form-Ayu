//
//  FormStepFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 03/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol FormDependencies {
    var stepDependence: StepProtocol { get set }
    var formSectionDependence: [FormSection] { get set }
}

public protocol FormStepFlowControllerDelegate {
    func formStepFlowControllerDelegateDidFinish()
}

public class FormStepFlowController: UIViewController, StepProtocolDelegate {
    
    private var dependencies: FormDependencies
    public var delegate: FormStepFlowControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(stepDependence: dependencies.stepDependence)
    }()
    
    lazy var formStepCollectionController: FormStepCollectionController = {
        let formCollection = FormStepCollectionController(stepDependence: dependencies.stepDependence, formSectionDependence: dependencies.formSectionDependence)
        formCollection.delegate = backgroundStepController
        return formCollection
    }()
    
    private lazy var stepBottomSegmentController: StepBottomSegmentController = {
        let stepBottomSegmentController = StepBottomSegmentController(delegate: self)
        return stepBottomSegmentController
    }()
    
    private lazy var pageControl: StepPageControlViewController = {
        let pageControl = StepPageControlViewController(stepDependence: dependencies.stepDependence)
        return pageControl
    }()
    
    public init(dependencies: FormDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        installChild(backgroundStepController)
        installChild(formStepCollectionController)
        installBottonSegment()
        installPageControl()
        
        dependencies.stepDependence.delegate = self
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
    
    private func installPageControl() {
        addChild(pageControl)
        view.addSubview(pageControl.view)
        stepBottomSegmentController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            pageControl.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.view.bottomAnchor.constraint(equalTo: stepBottomSegmentController.view.topAnchor)
        ])
    }
    
    public func moveToStep(at position: Int) {
        formStepCollectionController.moveToStep(at: position)
        backgroundStepController.moveToStep(at: position)
        pageControl.moveToStep(at: position)
    }
}

extension FormStepFlowController: StepBottomSegmentControllerDelegate {

    public func stepBottomSegmentControllerDelegate(didBack: StepBottomSegmentController) {
        guard dependencies.stepDependence.currentStep > 0 else { return }
        dependencies.stepDependence.currentStep = dependencies.stepDependence.currentStep-1
    }
    
    public func stepBottomSegmentControllerDelegate(didNext: StepBottomSegmentController) {
        guard dependencies.stepDependence.currentStep < dependencies.stepDependence.numberOfSteps else {
            delegate?.formStepFlowControllerDelegateDidFinish()
            return
        }
        
        dependencies.stepDependence.currentStep = dependencies.stepDependence.currentStep+1
    }
}
