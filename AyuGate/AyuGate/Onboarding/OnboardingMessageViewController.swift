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

class OnboardingMessageViewController: OnboardingStepCollectionViewCellContentController, FormStepFlowControllerDelegate, AYUActionButtonDelegate {

    private let navigation = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    public lazy var alreadyMei: AYUActionButton = {
        let button = AYUActionButton().setTitle("Já tenho MEI")
        button.status = .enabled
        return button
    }()
    
    private func setup() {
        
        view.addSubview(alreadyMei)
        
        alreadyMei.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        alreadyMei.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        alreadyMei.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -10).isActive = true
        
        actionButton.isHidden = false
        actionButton.delegate = self
        
        actionButton.actionHandler = {
            self.fetchForm()
        }
        
        alreadyMei.actionHandler = {
            self.fetchAlreadyMeiForm()
        }
    }
    
    func actionButtonDelegateDidTouch(_ sender: Any) {
        
    }
    
    func formStepFlowControllerDelegateDidFinish(controller: UIViewController) {
        let homeFlow = HomeFlowController()
        homeFlow.modalPresentationStyle = .fullScreen
        controller.present(homeFlow, animated: true, completion: nil)
    }
    
    private func fetchForm() {
        actionButton.status = .loading
//        https://run.mocky.io/v3/44091ba3-fb27-486b-834c-80b5b794e677
        
        NetworkManager.shared.makeRequest(request: .init(stringURL: "https://run.mocky.io/v3/f4b9e0e7-86f9-4c26-8e68-a424edfd4c1f")) { (result: Handler<Form>?, valid) in
            self.actionButton.status = .loaded
            guard let form = result?.response else { return }
            
            let formSections = form.sections.compactMap({ section -> Section in
                let maskFields = section.fields.map { field -> MaskField in
                    Mask(field: field)
                }
                
                let section = Section(sectionImageURL: section.imageSection?.url, layout: DefaultFormCollectionLayout(), masks: maskFields)
                return section
            })
            
            DispatchQueue.main.async {
                let step = Step(numberOfSteps: form.sections.count-1, currentStep: 0)
                let formDependencies = FormDependence(formSectionDependence: formSections, stepDependence: step)
                
                let flow = FormStepFlowController<FormStepCollectionViewCell>(dependencies: formDependencies)
                flow.delegate = self
                
                self.navigation.modalPresentationStyle = .fullScreen
                self.navigation.isNavigationBarHidden = true
                self.navigation.viewControllers = [flow]
                
                self.present(self.navigation, animated: true, completion: nil)
            }
        }
    }
    
    private func fetchAlreadyMeiForm() {
        alreadyMei.status = .loading
        NetworkManager.shared.makeRequest(request: .init(stringURL: "https://run.mocky.io/v3/ba9bd343-5059-42ba-8b82-599a79007e3f")) { (result: Handler<Form>?, valid) in
            self.alreadyMei.status = .loaded
            guard let form = result?.response else { return }
            
            let formSections = form.sections.compactMap({ section -> Section in
                let maskFields = section.fields.map { field -> MaskField in
                    Mask(field: field)
                }
                
                let section = Section(sectionImageURL: section.imageSection?.url, layout: DefaultFormCollectionLayout(), masks: maskFields)
                return section
            })
            
            DispatchQueue.main.async {
                let step = Step(numberOfSteps: form.sections.count-1, currentStep: 0)
                let formDependencies = FormDependence(formSectionDependence: formSections, stepDependence: step)
                
                let flow = FormStepFlowController<FormStepCollectionViewCell>(dependencies: formDependencies)
                flow.delegate = self
                
                self.navigation.modalPresentationStyle = .fullScreen
                self.navigation.isNavigationBarHidden = true
                self.navigation.viewControllers = [flow]
                
                self.present(self.navigation, animated: true, completion: nil)
            }
        }
    }
}

struct RGSection: FormSection {
    var sectionImageURL: String? = nil
    var layout: FormLayout? = DefaultFormCollectionLayout()
    var masks: [MaskField] = [Mock.DocumentRG(), Mock.OrgaoEmissor(), Mock.UF(), Mock.DocumentRGDate()]
    var sectionImage: UIImage? = Images.womanWithDocument
    var imageBorderSpace: CGFloat = 0
}
