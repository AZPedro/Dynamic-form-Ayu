//
//  RegisterFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class RegisterFlowController: UIViewController {
    
    private lazy var cpfRegisterViewController: CpfRegisterViewController = {
        let vc = CpfRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        return vc
    }()
    
//    private lazy var passwordRegisterViewController: PasswordRegisterViewController = {
//
//        return vc
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installChild(cpfRegisterViewController)
    }
    
    private func showPasswordForm(cpf: String) {
        let passwordRegisterViewController = PasswordRegisterViewController(type: .login, cpf: cpf)
        self.navigationController?.pushViewController(passwordRegisterViewController, animated: true)
    }
    
    private func showLoginScreen() {
        
    }
}

extension RegisterFlowController: CpfRegisterControllerDelegate {
    func cpfRegisterControllerDelegateVerify(didFinished model: CPFRegisterViewModel, controller: CpfRegisterViewController) {
        DispatchQueue.main.async {
            switch model.status {
            case .alreadyExists:
                controller.actionButton.updateState(state: .success)
                self.showPasswordForm(cpf: model.formattedCPF)
                break
            case .newUser:
                
                controller.actionButton.updateState(state: .success)
            case .notFound:
                controller.actionButton.updateState(state: .error)
                break
            }
        }
    }
}
