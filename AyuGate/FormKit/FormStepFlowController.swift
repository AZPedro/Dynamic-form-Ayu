//
//  FormStepFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 03/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

public protocol FormDependencies {
    var stepDependence: StepProtocol { get set }
    var formSectionDependence: [FormSection] { get set }
    var formLayoutDependence: FormLayout { get }
}

public struct DefaultFormCollectionLayout: FormLayout {
    public var delegate: FormLayoutDelegate?
    public var shouldShowNextStepButton: Bool
    public var isScrollEnabled: Bool
    
    public init(shouldShowNextStepButton: Bool = false, delegate: FormLayoutDelegate? = nil, isScrollEnabled: Bool = false){
        self.shouldShowNextStepButton = shouldShowNextStepButton
        self.isScrollEnabled = isScrollEnabled
        self.delegate = delegate
    }
}

extension FormDependencies {
    public var formLayoutDependence: FormLayout {
        return DefaultFormCollectionLayout()
    }
}

public protocol FormStepFlowControllerDelegate {
    func formStepFlowControllerDelegateDidFinish(controller: UIViewController)
}

public class FormStepFlowController<T: StepCollectionViewCell>: UIViewController, StepProtocolDelegate, FormLayoutDelegate {
    
    private var dependencies: FormDependencies
    public var delegate: FormStepFlowControllerDelegate?
    private var acitivity = AyuActivityView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupDependences()
    }
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(stepDependence: dependencies.stepDependence)
    }()
    
    lazy var formStepCollectionController: FormStepCollectionController<T> = {
        let formCollection = FormStepCollectionController<T>(stepDependence: dependencies.stepDependence, formSectionDependence: dependencies.formSectionDependence, formCollectionLayoutDependence: dependencies.formLayoutDependence)
        formCollection.delegate = self
        return formCollection
    }()
    
    private lazy var stepBottomSegmentController: StepBottomSegmentController = {
        let stepBottomSegmentController = StepBottomSegmentController(delegate: self)
        stepBottomSegmentController.isValid = dependencies.formLayoutDependence.shouldShowNextStepButton
        return stepBottomSegmentController
    }()
    
    private lazy var formStatusFlow: FormStatusFLowController = {
        let formStatusFLowControllerController = FormStatusFLowController()
        formStatusFLowControllerController.modalPresentationStyle = .fullScreen
        
        formStatusFLowControllerController.actionButtonHandler = { [weak self] controller in
            self?.delegate?.formStepFlowControllerDelegateDidFinish(controller: controller)
        }
        
        return formStatusFLowControllerController
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
    
    private func setupDependences() {
        installChild(backgroundStepController)
        
        view.add(view: acitivity)
        acitivity.state = .start
        
        dependencies.formSectionDependence = dependencies.formSectionDependence.map({ section -> FormSection in
            var section = section
            section.layout?.delegate = self
            return section
        })
        
        var count = 1
        dependencies.formSectionDependence.enumerated().forEach({ index, element in
            parseImage(urlString: element.sectionImageURL) { image in
                count += 1
                self.dependencies.formSectionDependence[index].sectionImage = image
        
                if count == self.dependencies.formSectionDependence.count {
                    DispatchQueue.main.async {
                        self.acitivity.state = .stop
                        self.show()
                    }
                }
            }
        })
    }
    
    private func show() {
        installChild(formStepCollectionController)
        
        if dependencies.formLayoutDependence.shouldShowStepBottom {
            installBottonSegment()
        }
        
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
    
    func parseImage(urlString: String?, completion: ((UIImage?) -> ())?) {
        let urlSession = URLSession.shared
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion?(nil)
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, let image = UIImage(data: data) else {
                completion?(nil)
                return
            }
            completion?(image)
        }.resume()
    }
    
    public func updateLayout(for sectionLayout: FormLayout) {
        pageControl.view.isHidden = !sectionLayout.shouldShowPageControl
//        stepBottomSegmentController.isValid = sectionLayout.shouldShowNextStepButton
        stepBottomSegmentController.isValid = true
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.formStepCollectionController.collectionView.isScrollEnabled = sectionLayout.isScrollEnabled
        }
    }
    
    public func updateSectionModel(with section: FormSection, for index: Int) {
        dependencies.formSectionDependence[index] = section
        formStepCollectionController.formSectionDependence[index] = section
    }
    
    public func updateSection(at index: Int, section: FormSection) {
        dependencies.formSectionDependence[index] = section
    }
    
    private func installPageControl() {
        addChild(pageControl)
        view.addSubview(pageControl.view)
        pageControl.didMove(toParent: self)
        
        pageControl.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if dependencies.formLayoutDependence.shouldShowStepBottom {
            pageControl.view.bottomAnchor.constraint(equalTo: stepBottomSegmentController.view.topAnchor).isActive = true
        } else {
            pageControl.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        }
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
        if dependencies.stepDependence.currentStep == dependencies.stepDependence.numberOfSteps {
            self.navigationController?.present(formStatusFlow, animated: true, completion: nil)
            return
        }
        guard dependencies.stepDependence.currentStep < dependencies.stepDependence.numberOfSteps else {
            delegate?.formStepFlowControllerDelegateDidFinish(controller: self)
            return
        }
        
        dependencies.stepDependence.currentStep = dependencies.stepDependence.currentStep+1
    }
}
