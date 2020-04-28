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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installChild(cpfRegisterViewController)
    }
    
    private func perform(cpf: String, for type: PasswordRegisterViewController.FormType) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let passwordRegisterViewController = PasswordRegisterViewController(type: type, cpf: cpf)
            self.navigationController?.pushViewController(passwordRegisterViewController, animated: true)
        }
    }
}

extension RegisterFlowController: CpfRegisterControllerDelegate {
    func cpfRegisterControllerDelegateVerify(didFinished model: CPFRegisterViewModel, controller: CpfRegisterViewController) {
        DispatchQueue.main.async {
            controller.actionButton.updateState(state: .success)
            self.perform(cpf: model.formattedCPF, for: .register)
            switch model.status {
            case .alreadyExists:
                controller.actionButton.updateState(state: .success)
                self.perform(cpf: model.formattedCPF, for: .login)
                break
            case .newUser:
                controller.actionButton.updateState(state: .success)
                self.perform(cpf: model.formattedCPF, for: .register)
            case .notFound:
                controller.actionButton.updateState(state: .error)
                break
            }
        }
    }
}
