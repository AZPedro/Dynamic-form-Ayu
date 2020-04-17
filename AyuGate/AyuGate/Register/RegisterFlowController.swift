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
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        installChild(cpfRegisterViewController)
    }
}

extension RegisterFlowController: CpfRegisterControllerDelegate {
    func cpfRegisterControllerDelegate(_ didFinished: CpfRegisterViewController?) {
    }
}
