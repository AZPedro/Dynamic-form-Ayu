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
        nav.viewControllers = [loginFlow]
//        nav.viewControllers = [onboardingFlow]
//        nav.viewControllers = [OnboardingMessageViewController(section: messageSection)]
        
//        }
        
        fetchForm()
        return nav
    }
    
    private func fetchForm() {
        NetworkManager.shared.makeRequest(request: .init(stringURL: "https://run.mocky.io/v3/707f065e-ecf1-47af-840c-c84240fa1824")) { (result: Handler<Form>?, valid) in
            
            guard let form = result?.response else { return }
            
            let formSections = form.sections.compactMap({ section -> Section in
                let maskFields = section.fields.map { field -> MaskField in
                    Mask(field: field)
                }
                
                let section = Section(sectionImageURL: section.imageSection?.url, layout: DefaultFormCollectionLayout(), masks: maskFields)
                return section
            })
            
            let step = Step(numberOfSteps: form.sections.count-1, currentStep: 0)
            
            let formDependencies = FormDependence(formSectionDependence: formSections, stepDependence: step)
            
            DispatchQueue.main.async {
                let flow = FormStepFlowController<FormStepCollectionViewCell>(dependencies: formDependencies)
                flow.modalPresentationStyle = .fullScreen
                self.nav.present(flow, animated: true, completion: nil)
            }
        }
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
    var sectionImageURL: String?
    var layout: FormLayout? = DefaultFormCollectionLayout()
    var sectionImage: UIImage? = nil
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

struct Mask: MaskField {
    var mask: String?
    var keyboardType: FormFieldContent.Keyboard
    var validatorQuery: String?
    var formModel: FormFieldContent.Model
    var fieldType: FormFieldContent.FieldType
    var isSecurity: Bool
    
    public init(field: Form.Field) {
        self.mask = nil
        self.keyboardType = FormFieldContent.Keyboard(rawValue: field.keyboardType) ?? .default
        self.validatorQuery = field.validate
        self.formModel = FormFieldContent.Model(placeholder: field.placeholder, title: field.title, value: field.value)
        self.fieldType = FormFieldContent.FieldType(rawValue: field.type) ?? .text
        self.isSecurity = field.isSecurity
    }
}

extension Mask {
    static func fields(from: [Form.Field]) {
        
    }
}
