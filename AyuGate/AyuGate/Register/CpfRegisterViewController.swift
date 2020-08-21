//
//  CpfRegisterViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

class CpfRegisterViewController: AYUViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var delegate: CpfRegisterFlowDelegate?
    
    private let networkManager = NetworkManager.shared
    
    lazy var cpfFormView: FormFieldContent = {
        let view = FormFieldContent(maskField: maskDependence)
        return view
    }()
    
    var maskDependence: MaskField
    
    init(maskDependence: MaskField) {
        self.maskDependence = maskDependence
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func buildUI() {
        view.backgroundColor = .white
//        actionButton.isEnabled = false
        
        setupCPFFormView()
        
//        actionHandler = { [weak self] in
//            self?.verifyCPF()
//        }
        
//        cpfFormView.validationHandler = { [weak self] isValid in
//            self?.actionButton.isEnabled = isValid
//        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    private func setupCPFFormView() {
        view.addSubview(cpfFormView)
        cpfFormView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height * 0.1).isActive = true
        cpfFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cpfFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cpfFormView.model = FormFieldContent.Model(placeholder: "CPF", title: "Insira seu CPF", validator: { finished in
            print("field validado")
        })
    }
    
    private func verifyCPF() {
//        guard let cpfValue = cpfFormView.value else { return }
//
//        let request = AYURoute(path: .verify(cpf: cpfValue)).resquest
//
//        networkManager.makeRequest(request: request) { (result: Handler<Verify>?, error) in
//            guard let result = result?.response else {
//                return
//            }
//
//            let model = CPFVerifyViewModel(model: result, cpf: cpfValue)
//            self.delegate?.cpfRegisterControllerDelegateVerify(didFinished: model, controller: self)
//        }
    }
    
    @objc func dismissKeyboard() {
//        self.cpfFormView.textField.resignFirstResponder()
    }
}
