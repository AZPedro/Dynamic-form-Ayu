//
//  MockLoginScreenController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 25/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

class MockPasswordScreenController: UIViewController {
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(stepDependence: dependence)
    }()
    
    lazy var passwordField: FormFieldContent = {
        return FormFieldContent(maskField: Mock.PasswordField())
    }()
    
    let actionButton = AYUButton(title: "Avançar")
    
    private var dependence: StepProtocol
    private var loginService: LoginServiceProtocol
    
    public init(dependence: StepProtocol, validationService: LoginServiceProtocol) {
        self.dependence = dependence
        self.loginService = validationService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(passwordField)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        passwordField.model = Mock.PasswordField().formModel
        actionButton.buttonTheme = .formTheme
        actionButton.backgroundColor = .white
        actionButton.clipsToBounds = true
        actionButton.layer.cornerRadius = 5

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        actionButton.handler = { [weak self] in
            self?.buttonAction()
        }
        
        passwordField.validationHandler = { [weak self] isValid in
            self?.actionButton.isEnabled = true
        }
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func buttonAction() {
        loginService.login(cpf: passwordField.value ?? "", password: passwordField.value ?? "") { (result) in
            do {
                let response = try result.get()
                
                switch response.status {
                case .canBeMei, .needsInfo:
                    let messagecontroller = MockMeiMessageUserStatusController(dependence: dependence, status: response.status)
                    self.navigationController?.pushViewController(messagecontroller, animated: true)
                case .valid:
                    let homeController = HomeFlowController()
                    self.navigationController?.pushViewController(homeController, animated: true)
                }
            } catch {
                // alert error
                print(error)
            }
        }
    }
}


