//
//  PasswordRegisterViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class PasswordRegisterViewController: AYUActionButtonViewController {
    
    public enum FormType {
        case login, register
    }
    
    struct Constants {
        static let cpfHeaderLabelYConstant = UIScreen.main.bounds.height / 5
    }
    
    var delegate: CpfRegisterFlowDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private let type: FormType
    private let cpf: String
    private var password: String = ""
    
    init(type: FormType, cpf: String) {
        self.type = type
        self.cpf = cpf
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cpfHeaderLabelHeightConstraint: NSLayoutConstraint?
    
    private let passwordField: AYUTextField = {
        let textField = AYUTextField()
        textField.textField.isSecureTextEntry = true
        textField.textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeHolder.text = "Senha"
        return textField
    }()
    
    private let passwordConfirmationField: AYUTextField = {
        let textField = AYUTextField()
        textField.textField.isSecureTextEntry = true
        textField.textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        
        backArrow.isHidden = false
        
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
        
        cpfHeaderLabel.text = cpf
        passwordField.titleLabel.text = self.type == .login ? "Senha" : "Criar uma senha"
        passwordConfirmationField.isHidden = self.type == .login ? true : false
        
        actionHandler = {
            self.actionButton.updateState(state: .loading)
            if self.isValidPasswordFields() {
                self.perform()
            }
        }
    }
    
    private func perform() {
        let cpf = self.cpf.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")
        var request: AYURequest
        
        switch type {
        case .login:
            let path = AYURoute.AyuPath.login(cpf: cpf, password: password)
            request = AYURoute.init(path: path).resquest
        case .register:
            let path = AYURoute.AyuPath.signUP(cpf: cpf, password: password)
            request = AYURoute.init(path: path).resquest
        }
        
        callRequest(request: request)
    }
    
    private func callRequest(request: AYURequest) {
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<Login>?, validation) in
            DispatchQueue.main.async {
                if let validation = validation {
                    let model = PasswordValidationViewModel(model: validation)
                    self.passwordField.errorLabel.text = model.validationMessage
                    self.actionButton.updateState(state: .error)
                    self.passwordField.updateState(state: .failed)
                } else if let result = result?.response  {
                    let session = SessionModel(acessToke: result.accessToken, refreshToken: result.refreshToken)
                    self.delegate?.cpfRegisterControllerDelegateLogin(didFinished: session, controller: self)
                }
            }
        }
    }
    
    private func isValidPasswordFields() -> Bool {
        switch type {
        case .login:
            guard let passwordText = self.passwordField.textField.text else {
                return false
            }
            password = passwordText
            return true
            
        case .register:
            guard let passwordText = self.passwordField.textField.text,
                let passwordConfirmationText = self.passwordConfirmationField.textField.text else { return false }
            
            if passwordText != passwordConfirmationText,
                passwordText.isEmpty || passwordConfirmationText.isEmpty {
                    
                    passwordField.errorLabel.text = "Senha e confirmação de senha devem ser iguais"
                    actionButton.updateState(state: .error)
                    passwordConfirmationField.updateState(state: .failed)
                    passwordField.updateState(state: .failed)
                    return false
            }
            
            if passwordText.count < 6 || passwordConfirmationText.count < 6 {
                passwordField.errorLabel.text = "Senha deve ter mais que seis digitos"
                passwordConfirmationField.updateState(state: .failed)
                passwordField.updateState(state: .failed)
                actionButton.updateState(state: .error)
                return false
            }
            
            password = passwordText
            return true
        }
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
