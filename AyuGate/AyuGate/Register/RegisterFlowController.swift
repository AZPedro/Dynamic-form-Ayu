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
    
    private lazy var passwordRegisterViewController: PasswordRegisterViewController = {
        let vc = PasswordRegisterViewController()
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installChild(passwordRegisterViewController)
    }
    
    private func showPasswordForm() {
        self.navigationController?.pushViewController(passwordRegisterViewController, animated: true)
    }
}

extension RegisterFlowController: CpfRegisterControllerDelegate {
    func cpfRegisterControllerDelegate(_ didFinished: CpfRegisterViewController?) {
        showPasswordForm()
    }
}
