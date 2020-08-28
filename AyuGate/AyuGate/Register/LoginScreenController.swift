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

class LoginScreenController: AYUActionButtonViewController {
    
    lazy var backgroundStepController: BackgroundStepController = {
        return BackgroundStepController(stepDependence: dependence)
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var cpfField: FormFieldContent = {
        return FormFieldContent(maskField: Mock.CPFField())
    }()
    
//    private let actionButton = AYUActionButton()
//        .setTitle("Avançar")
    
    private var dependence: StepProtocol
    
    public init(dependence: StepProtocol) {
        self.dependence = dependence
        super.init()
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
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            cpfField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            cpfField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cpfField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: AYUActionButton.Constants.defaulsConstants),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -AYUActionButton.Constants.defaulsConstants),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -AYUActionButton.Constants.defaulsConstants),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        cpfField.model = Mock.CPFField().formModel
        imageView.image = Images.womanWithComputer

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        cpfField.validationHandler = { [weak self] isValid in
            self?.actionButton.status = .enabled
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

enum ProfileStatus {
    case valid
    case needsInfo
    case canBeMei
}
