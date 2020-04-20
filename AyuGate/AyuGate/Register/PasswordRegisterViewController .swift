//
//  PasswordRegisterViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class PasswordRegisterViewController: AYUActionButtonViewController {
    
    struct Constants {
        static let cpfHeaderLabelYConstant = UIScreen.main.bounds.height / 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private var cpfHeaderLabelHeightConstraint: NSLayoutConstraint?
    
    private let passwordField: AYUTextField = {
        let textField = AYUTextField()
        textField.textField.isSecureTextEntry = true
        textField.textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.titleLabel.text = "Criar uma senha"
        textField.placeHolder.text = "Senha"
        return textField
    }()
    
    private let passwordConfirmationField: AYUTextField = {
        let textField = AYUTextField()
        textField.textField.isSecureTextEntry = true
        textField.textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.errorLabel.text = "Senha e confirmação de senha devem ser iguais"
        textField.placeHolder.text = "Confirmar senha"
        return textField
    }()
    
    private let checkMarkIconImageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "checkmark")
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 23).isActive = true
        i.widthAnchor.constraint(equalToConstant: 23).isActive = true
        return i
    }()
    
    private let cpfHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "180.049.067-45"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func buildUI() {
        view.addSubview(passwordField)
        view.addSubview(passwordConfirmationField)
        view.addSubview(checkMarkIconImageView)
        view.addSubview(cpfHeaderLabel)
        
        cpfHeaderLabelHeightConstraint = cpfHeaderLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Constants.cpfHeaderLabelYConstant)
        cpfHeaderLabelHeightConstraint?.isActive = true
        cpfHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        checkMarkIconImageView.centerYAnchor.constraint(equalTo: cpfHeaderLabel.centerYAnchor).isActive = true
        checkMarkIconImageView.leftAnchor.constraint(equalTo: cpfHeaderLabel.rightAnchor, constant: 10).isActive = true
        
        passwordField.topAnchor.constraint(equalTo: cpfHeaderLabel.bottomAnchor, constant: 10).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        passwordConfirmationField.topAnchor.constraint(equalTo: passwordField.bottomAnchor).isActive = true
        passwordConfirmationField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordConfirmationField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        actionHandler = {
            if self.isValidPasswordFields() {
                self.actionButton.updateState(state: .success)
            }
        }
    }
    
    private func isValidPasswordFields() -> Bool {
        guard let passwordText = self.passwordField.textField.text,
            let passwordConfirmationText = self.passwordConfirmationField.textField.text,
            passwordText == passwordConfirmationText,
            !passwordText.isEmpty && !passwordConfirmationText.isEmpty else {
                
                self.actionButton.updateState(state: .error)
                self.passwordConfirmationField.updateState(state: .failed)
                self.passwordField.updateState(state: .failed)
                return false
        }
        
        return true
    }
    
    override func keyboardWillShow(notification: Notification) {
        super.keyboardWillShow(notification: notification)
        view.setNeedsLayout()

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.cpfHeaderLabelHeightConstraint?.constant = -Constants.cpfHeaderLabelYConstant - 50
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func keyboardWillHide(notification: Notification) {
        super.keyboardWillHide(notification: notification)
        view.setNeedsLayout()

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.cpfHeaderLabelHeightConstraint?.constant = -Constants.cpfHeaderLabelYConstant
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}
