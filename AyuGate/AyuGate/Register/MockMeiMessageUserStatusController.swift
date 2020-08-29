////
////  MockLoginScreenController.swift
////  AyuGate
////
////  Created by Pedro Azevedo on 25/08/20.
////  Copyright © 2020 AyuGate. All rights reserved.
////
//
//import UIKit
//import FormKit
//
//class MockMeiMessageUserStatusController: UIViewController, FormStepFlowControllerDelegate {
//
//    lazy var backgroundStepController: BackgroundStepController = {
//        return BackgroundStepController(stepDependence: dependence)
//    }()
//    
//    lazy var messageLabel = UILabel()
//    let actionButton = AYUButton(title: "Avançar")
//    
//    
//    private var dependence: StepProtocol
//    private var status: ProfileStatus
//    
//    public init(dependence: StepProtocol, status: ProfileStatus) {
//        self.dependence = dependence
//        self.status = status
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        build()
//    }
//    
//    private func build() {
//        installBackground()
//        setupComponents()
//    }
//    
//    private func installBackground() {
//        installChild(backgroundStepController)
//    }
//    
//    private func setupComponents() {
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        actionButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(messageLabel)
//        view.addSubview(actionButton)
//        
//        NSLayoutConstraint.activate([
//            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            
//            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
//            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            actionButton.heightAnchor.constraint(equalToConstant: 45)
//        ])
//        
//        actionButton.backgroundColor = .white
//        actionButton.clipsToBounds = true
//        actionButton.layer.cornerRadius = 5
//        actionButton.buttonTheme = .formTheme
//        
//        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        messageLabel.textColor = .white
//        messageLabel.numberOfLines = 0
//
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
//
//        switch status {
//        case .canBeMei:
//            messageLabel.text = "Verificamos que agora você já pode ser MEI"
//        case .needsInfo:
//            messageLabel.text = "Verificamos que você precisa ajustar alguns dados do seu cadastro"
//        default:
//            break
//        }
//
//        actionButton.handler = { [weak self] in
//            self?.buttonAction()
//        }
//    }
//
//    @objc private func dismissKeyboard() {
//        view.endEditing(true)
//    }
//    
//    let meiFormFlowSections: [FormSection] = [
//        CPFSection(masks: [Mock.NameField()]),
//        CPFSection(masks: [Mock.EmailField()]),
//        CPFSection(masks: [Mock.BirthDayDate()]),
//        CPFSection(sectionImage: nil, masks: [Mock.DocumentRG(), Mock.OrgaoEmissor(), Mock.UF(), Mock.DocumentRGDate()])
//    ]
//    
//    let meiFormFlowUncompletedSections: [FormSection] = [
//        CPFSection(masks: [Mock.BirthDayDate()]),
//        CPFSection(sectionImage: nil, masks: [Mock.DocumentRG(), Mock.OrgaoEmissor(), Mock.UF(), Mock.DocumentRGDate()])
//    ]
//    
//    private lazy var meiFormFlowDependencies: CPFFormDepencies = {
//        return CPFFormDepencies(formSectionDependence: meiFormFlowSections ,stepDependence: Step(numberOfSteps: meiFormFlowSections.count-1, currentStep: 0))
//    }()
//    
//    private lazy var meiFormFlowUnCompletedDependencies: CPFFormDepencies = {
//        return CPFFormDepencies(formSectionDependence: meiFormFlowUncompletedSections ,stepDependence: Step(numberOfSteps: meiFormFlowUncompletedSections.count-1, currentStep: 0))
//    }()
//    
////    // Formulario para MEI vazio
////    private lazy var meiFormFlow: FormStepFlowController = {
////        let flow = FormStepFlowController(dependencies: meiFormFlowDependencies)
////        flow.delegate = self
////        return flow
////    }()
////
////    // Formulário com campos que estão faltando
////    private lazy var meiFormUnCompletedFlow: FormStepFlowController = {
////        let flow = FormStepFlowController(dependencies: meiFormFlowUnCompletedDependencies)
////        flow.delegate = self
////        return flow
////    }()
//    
//    private func buttonAction() {
//        switch status {
//        case .canBeMei:
//            self.navigationController?.pushViewController(meiFormFlow, animated: true)
//        case .needsInfo:
//            self.navigationController?.pushViewController(meiFormUnCompletedFlow, animated: true)
//        default:
//            break
//        }
//    }
//    
//    func formStepFlowControllerDelegateDidFinish() {
//        self.navigationController?.pushViewController(HomeFlowController(), animated: true)
//    }
//}
