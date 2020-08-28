//
//  LoginFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 28/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

class LoginFlowController: UIViewController {
    
    let network = NetworkManager()
    
    private lazy var loginController: LoginScreenController = {
        let loginController = LoginScreenController()
        loginController.delegate = self
        return loginController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        installChild(loginController)
    }
    
    private func verifyCPF(text: String?) {
        guard let cpfValue = text else { return }

        let request = AYURoute(path: .verify(cpf: cpfValue)).resquest

        network.makeRequest(request: request) { (result: Handler<Verify>?, error) in
            guard let result = result?.response else {
                return
            }

            let model = CPFVerifyViewModel(model: result, cpf: cpfValue)
            DispatchQueue.main.async {
                self.loginController.verifyViewModel = model
            }
        }
    }
}

extension LoginFlowController: LoginScreenControllerDelegate {
    func loginScreenControllerDelegateLogin(field: FormFieldContent) {
//        performLogin()
    }
    
    func loginScreenControllerDelegateVerifyCPF(field: FormFieldContent) {
        verifyCPF(text: field.value)
    }
}
 
