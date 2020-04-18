//
//  CpfRegisterViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol CpfRegisterControllerDelegate {
    func cpfRegisterControllerDelegate(_ didFinished: CpfRegisterViewController?)
}

class CpfRegisterViewController: AYUActionButtonViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var delegate: CpfRegisterControllerDelegate?
    
    private lazy var cpfFormView: AYUCPFFormView  = {
        let view = AYUCPFFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        actionButton.isEnabled = false
        
        setupCPFFormView()
        
        actionHandler = { [weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self?.actionButton.updateState(state: .success)
                self?.delegate?.cpfRegisterControllerDelegate(self)
            }
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
    
    
    
    @objc func dismissKeyboard() {
        self.cpfFormView.textField.resignFirstResponder()
    }
}
