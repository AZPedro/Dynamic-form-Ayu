//
//  RegisterScreenController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 28/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit
import AyuKit

protocol RegisterScreenControllerDelegate {
    func registerScreenControllerDelegateDidFinish(password: FormFieldContent, passwordConfirmation: FormFieldContent)
}

class RegisterScreenController: AYUActionButtonViewController {

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
    
    lazy var passwordField: FormFieldContent = {
        return FormFieldContent(maskField: Mock.PasswordField())
    }()
    
    lazy var confirmPassword: FormFieldContent = {
        let confirmPassword = FormFieldContent(maskField: Mock.PasswordField())
        return confirmPassword
    }()
    
    var delegate: RegisterScreenControllerDelegate?
    
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
        confirmPassword.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(passwordField)
        view.addSubview(confirmPassword)
        view.addSubview(actionButton)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            confirmPassword.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
            confirmPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AYUActionButton.Constants.defaulsConstants),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AYUActionButton.Constants.defaulsConstants),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AYUActionButton.Constants.defaulsConstants),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        actionButton.delegate = self
        passwordField.model = Mock.CPFField().formModel
        imageView.image = Images.womanWithComputer

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        passwordField.validationSectionHandler = { [weak self] isValid in
            self?.actionButton.status = isValid ? .enabled : .disabled
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterScreenController: AYUActionButtonDelegate {
    func actionButtonDelegateDidTouch(_ sender: Any) {
   
    }
    
    func passwordFieldModel(with title: String) -> FormFieldContent.Model {
        return FormFieldContent.Model(placeholder: "Senha", title: title)
    }
}
