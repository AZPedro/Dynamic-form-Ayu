//
//  CpfRegisterViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class CpfRegisterViewController: AYUActionButtonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var delegate: CpfRegisterFlowDelegate?
    
    private let networkManager = NetworkManager.shared
    
    lazy var cpfFormView: AYUCPFFormView  = {
        let view = AYUCPFFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        actionButton.isEnabled = false
        
        setupCPFFormView()
        
        actionHandler = { [weak self] in
            self?.verifyCPF()
        }
        
        cpfFormView.validationHandler = { [weak self] isValid in
            self?.actionButton.isEnabled = isValid
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    private func setupCPFFormView() {
        view.addSubview(cpfFormView)
        cpfFormView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height * 0.1).isActive = true
        cpfFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cpfFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    private func verifyCPF() {
        guard let cpfValue = cpfFormView.value else { return }
        
        let request = AYURoute(path: .verify(cpf: cpfValue)).resquest
        
        networkManager.makeRequest(request: request) { (result: Handler<Verify>?, error) in
            guard let result = result?.response else {
                return
            }
            
            let model = CPFVerifyViewModel(model: result, cpf: cpfValue)
            self.delegate?.cpfRegisterControllerDelegateVerify(didFinished: model, controller: self)
        }
    }
    
    @objc func dismissKeyboard() {
        self.cpfFormView.textField.resignFirstResponder()
    }
}
