//
//  RegisterFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol RegisterFlowControllerDelegate {
    func registerFlowControllerDelegate(_ didFinished: RegisterFlowController?)
}

class RegisterFlowController: AYUViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private lazy var cpfFormView: AYUCPFFormView  = {
        let view = AYUCPFFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        view.addSubview(cpfFormView)
        cpfFormView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height * 0.1).isActive = true
        cpfFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cpfFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
}
