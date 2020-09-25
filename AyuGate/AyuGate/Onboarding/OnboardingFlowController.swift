//
//  OnboardingFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 28/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit
import AyuKit

class OnboardingFlowController: UIViewController {
    
    private lazy var onboardingStepDependence: OnboardingStepProtocol = {
        return OnboardingStepProtocol(numberOfSteps: onboardingFormSections.count-1, currentStep: 0)
    }()
    
    private let onboardingCollectionLayout = OnboardingCollectionLayout()
    
    private lazy var onboardingFormSections: [FormSection] = {
        return [OnboardingFirstSection(messageText: "Tudo que você precisa para a gestão do seu RH em um único lugar", sectionImage: Images.manWalkingWithCellPhone),
                OnboardingSecondFormSection(messageText: "Gestão completa e descomplicada da sua folha de pagamento.", sectionImage: Images.womanReading),
                OnboardingPushFormSection(messageText: "Receba notificações e fique por dentro de tudo que acontece."),
                LoginFormSection()
        ]
    }()
    
    private lazy var onboardingStepFlow: FormStepFlowController<OnboardingStepCollectionViewCell> = {
        let onboardingStepFlow = FormStepFlowController<OnboardingStepCollectionViewCell>(dependencies: OnboardingFlowDepencies(formLayoutDependence: onboardingCollectionLayout, stepDependence: onboardingStepDependence, formSectionDependence: onboardingFormSections))
        onboardingStepFlow.delegate = self
        return onboardingStepFlow
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        installChild(onboardingStepFlow)
    }
}

extension OnboardingFlowController: FormStepFlowControllerDelegate {
    func formStepFlowControllerDelegateDidFinish(controller: UIViewController) {
    
    }
}

struct OnboardingFlowDepencies: FormDependencies {
    var formLayoutDependence: FormLayout
    var stepDependence: StepProtocol
    var formSectionDependence: [FormSection]
}

struct OnboardingStepProtocol: StepProtocol {
    var numberOfSteps: Int
    
    var currentStep: Int {
        didSet {
            delegate?.moveToStep(at: currentStep)
        }
    }
    
    var delegate: StepProtocolDelegate?
}

struct OnboardingFirstSection: OnboardingFormSection {
    var sectionImageURL: String? = "https://firebasestorage.googleapis.com/v0/b/ios-project-1e1ca.appspot.com/o/manWalking.png?alt=media&token=bb369e72-18b4-4cca-8e69-8dc3d1673924"
    
    var layout: FormLayout? = DefaultFormCollectionLayout(isScrollEnabled: true)

    var imagePosition: NSTextAlignment = .left
    var messageText: String
    var sectionImage: UIImage? = Images.manWalkingWithCellPhone
}

struct OnboardingSecondFormSection: OnboardingFormSection {
    var sectionImageURL: String? = "https://firebasestorage.googleapis.com/v0/b/ios-project-1e1ca.appspot.com/o/womanReading.png?alt=media&token=248b86f0-c79f-4436-8a09-539151a519d6"
    
    var layout: FormLayout? = DefaultFormCollectionLayout(isScrollEnabled: true)
    var imagePosition: NSTextAlignment = .right
    var messageText: String
    var sectionImage: UIImage? = Images.womanReading
}

struct OnboardingPushFormSection: OnboardingFormSection {
    var sectionImageURL: String? = "https://firebasestorage.googleapis.com/v0/b/ios-project-1e1ca.appspot.com/o/womanReading.png?alt=media&token=248b86f0-c79f-4436-8a09-539151a519d6"
    
    var layout: FormLayout? = DefaultFormCollectionLayout(isScrollEnabled: true)
    var imagePosition: NSTextAlignment = .right
    var messageText: String
    var sectionImage: UIImage? = Images.womanReading
}

struct OnboardingCollectionLayout: FormLayout {
    var delegate: FormLayoutDelegate?
    var shouldShowNextStepButton: Bool = false
    var shouldShowStepBottom: Bool = false
    var isScrollEnabled: Bool = true
}

struct LoginFormLayout: FormLayout {
    var shouldShowNextStepButton: Bool = false
    var shouldShowStepBottom: Bool = false
    var isScrollEnabled: Bool = true
    var shouldShowPageControl: Bool = false
    var delegate: FormLayoutDelegate?
}

// login section
struct LoginFormSection: LoginFormSectionProtocol {
    var sectionImageURL: String? = nil
    var masks: [MaskField] = []
    var sectionImage: UIImage? = nil
    var layout: FormLayout? = LoginFormLayout()
}
