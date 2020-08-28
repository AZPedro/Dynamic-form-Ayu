//
//  LoginScreenController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 25/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit
import AyuKit

protocol LoginScreenControllerDelegate {
    func loginScreenControllerDelegateVerifyCPF(field: FormFieldContent)
    func loginScreenControllerDelegateLogin(field: FormFieldContent)
}

class LoginScreenController: AYUActionButtonViewController {

    let backgroundStepDepence: StepProtocol = {
        return LoginBackgroundStep()
    }()
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(stepDependence: backgroundStepDepence)
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var fieldContent: FormFieldContent = {
        return FormFieldContent(maskField: Mock.CPFField())
    }()
    
    var delegate: LoginScreenControllerDelegate?
    private var controllerState: ControllerState = .cpf
    
    private enum ControllerState {
        case cpf
        case password
    }
    
    var verifyViewModel: CPFVerifyViewModel? {
        didSet {
            updateControllerStatus()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }
    
    private func build() {
        installBackground()
        setupComponents()
    }
    
    private func installBackground() {
        installChild(backgroundStepController)
    }
    
    private func setupComponents() {
        fieldContent.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(fieldContent)
        view.addSubview(actionButton)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            fieldContent.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            fieldContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fieldContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AYUActionButton.Constants.defaulsConstants),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AYUActionButton.Constants.defaulsConstants),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AYUActionButton.Constants.defaulsConstants),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        actionButton.delegate = self
        fieldContent.model = Mock.CPFField().formModel
        imageView.image = Images.womanWithComputer

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        fieldContent.validationHandler = { [weak self] isValid in
            self?.actionButton.status = isValid ? .enabled : .disabled
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateControllerStatus() {
        guard let verifyModel = verifyViewModel else { return }
        switch verifyModel.status {
        case .alreadyExists:
            actionButton.status = .loaded
            fieldContent.endEditing(true)
            fieldContent.maskField = Mock.PasswordField()
            fieldContent.model = passwordFieldModel(with: verifyModel.formattedCPF)
            fieldContent.titleAccessoryView.image = Images.checkMarck
            fieldContent.titleAccessoryView.isHidden = false
            self.controllerState = .password
        case .newUser:
            actionButton.status = .loaded
        case .notFound:
            actionButton.status = .loaded
            fieldContent.fieldIsValid = false
        }
    }
}

extension LoginScreenController: AYUActionButtonDelegate {
    func actionButtonDelegateDidTouch(_ sender: Any) {
        actionButton.status = .loading
        switch controllerState {
        case .cpf:
            delegate?.loginScreenControllerDelegateVerifyCPF(field: fieldContent)
        case .password:
            delegate?.loginScreenControllerDelegateLogin(field: fieldContent)
        }
    }
    
    func passwordFieldModel(with title: String) -> FormFieldContent.Model {
        return FormFieldContent.Model(placeholder: "Senha", title: title, errorMessage: "Senha inválida")
    }
}

struct LoginBackgroundStep: StepProtocol {
    var numberOfSteps: Int = 0
    var currentStep: Int = 0
    var delegate: StepProtocolDelegate?
}

enum ProfileStatus {
    case valid
    case needsInfo
    case canBeMei
}
