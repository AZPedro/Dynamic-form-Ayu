//
//  MockLoginScreenController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 25/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

class MockLoginScreenController: UIViewController {
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(stepDependence: dependence)
    }()
    
    lazy var cpfField: FormFieldContent = {
        return FormFieldContent(maskField: Mock.CPFField())
    }()
    
    let actionButton = AYUButton(title: "Avançar")
    
    private var dependence: StepProtocol
    private var validationService: CpfValidationServiceProtocol
    
    public init(dependence: StepProtocol, validationService: CpfValidationServiceProtocol) {
        self.dependence = dependence
        self.validationService = validationService
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
        cpfField.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cpfField)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            cpfField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cpfField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cpfField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        actionButton.buttonTheme = .formTheme
        
        cpfField.model = Mock.CPFField().formModel
        actionButton.backgroundColor = .white
        actionButton.clipsToBounds = true
        actionButton.layer.cornerRadius = 5

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        actionButton.handler = { [weak self] in
            self?.buttonAction()
        }
        
        cpfField.validationHandler = { [weak self] isValid in
            self?.actionButton.isEnabled = true
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func buttonAction() {
        validationService.validate(cpf: cpfField.value ?? "") { (result) in
            do {
                let response = try result.get()
                switch response {
                case .invalid:
                    break
                    // alert error
                case .valid:
                    self.actionButton.updateState(state: .success)
                    let passwordController = MockPasswordScreenController(dependence: self.dependence, validationService: LoginService())
                    self.navigationController?.pushViewController(passwordController, animated: true)
                    // showPassword
                }
                
            } catch {
                // alert error
                print(error)
            }
        }
    }
}

///
public enum CpfStatus {
    case valid
    case invalid
}
public protocol CpfValidationServiceProtocol {
    func validate(cpf: String, completion: @escaping (Result<CpfStatus, Error>) -> Void)
}
public class CpfValidationService: CpfValidationServiceProtocol {
    
    public func validate(cpf: String, completion: @escaping (Result<CpfStatus, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            switch cpf {
            case "180.193.300-62":
                completion( .success(.invalid))
            default:
                completion( .success(.valid))
            }
        }
    }
}
enum ProfileStatus {
    case valid
    case needsInfo
    case canBeMei
}

public struct LoginResponse {
    let status: ProfileStatus
}

public protocol LoginServiceProtocol {
    func login(cpf: String, password: String, completion: (Result<LoginResponse, Error>) -> Void)
}

public class LoginService: LoginServiceProtocol {
   public func login(cpf: String, password: String, completion: (Result<LoginResponse, Error>) -> Void) {
        switch password {
        case "1234":
            completion(.success(LoginResponse(status: .needsInfo)))
        case "5678":
            completion(.success(LoginResponse(status: .canBeMei)))
        default:
            completion(.success(LoginResponse(status: .valid)))
        }
    }
}
