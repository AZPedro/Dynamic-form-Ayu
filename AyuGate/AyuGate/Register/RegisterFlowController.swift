//
//  RegisterFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol CpfRegisterFlowDelegate {
    func cpfRegisterControllerDelegateVerify(didFinished model: CPFVerifyViewModel, controller: CpfRegisterViewController)
    func cpfRegisterControllerDelegateLogin(didFinished model: SessionModel, controller: PasswordRegisterViewController)
}

class RegisterFlowController: UIViewController {
    
    private lazy var cpfRegisterViewController: CpfRegisterViewController = {
        let vc = CpfRegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        installChild(cpfRegisterViewController)
    }
    
    private func perform(cpf: String, for type: PasswordRegisterViewController.FormType) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let passwordRegisterViewController = PasswordRegisterViewController(type: type, cpf: cpf)
            passwordRegisterViewController.delegate = self
            self.navigationController?.pushViewController(passwordRegisterViewController, animated: true)
        }
    }
    
    private func fetchProfile() {
        guard let profileID = SessionManager.shared.profileId else {
            return
        }

        let request = AYURoute(path: .profile(id: profileID)).resquest
        
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<ProfileParsable>?, validation) in
            guard let profile = result?.response else {
                return
            }
            
            SessionManager.shared.saveAccount(profile: profile)
            self.showHome()
        }
    }
    
    private func showHome() {
        DispatchQueue.main.async {
            let homeFlow = HomeFlowController()
            homeFlow.modalPresentationStyle = .fullScreen
            self.navigationController?.present(homeFlow, animated: true, completion: nil)
        }
    }
}

extension RegisterFlowController: CpfRegisterFlowDelegate {
    
    func cpfRegisterControllerDelegateVerify(didFinished model: CPFVerifyViewModel, controller: CpfRegisterViewController) {
        DispatchQueue.main.async {
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
                controller.cpfFormView.animateError(shouldShow: true)
                break
            }
        }
    }
    
    func cpfRegisterControllerDelegateLogin(didFinished model: SessionModel, controller: PasswordRegisterViewController) {
        SessionManager.shared.authToken = model.acessToken
        SessionManager.shared.refreshToken = model.refreshToken
        
        fetchProfile()
    }
}
