//
//  PasswordRegisterViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class PasswordRegisterViewController: AYUActionButtonViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private lazy var passwordField: AYUTextField = {
        let textField = AYUTextField()
        textField.textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeHolder.text = "SENHA"
        textField.titleLabel.text = "Crie uma senha"
        return textField
    }()
    
    private lazy var passwordConfirmationField: AYUTextField = {
        let textField = AYUTextField()
        textField.textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeHolder.text = "CONFIRMAR SENHA"
        return textField
    }()
    
    private func buildUI() {
        view.addSubview(passwordField)
        view.addSubview(passwordConfirmationField)
        
        passwordField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height * 0.1).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        passwordConfirmationField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 5).isActive = true
        passwordConfirmationField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordConfirmationField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }

}
