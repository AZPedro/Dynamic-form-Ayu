//
//  LoginFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 28/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit
import AyuKit

class LoginFlowController: UIViewController {
    
    let network = NetworkManager()
    
    private lazy var loginController: LoginScreenController = {
        let loginController = LoginScreenController(section: LoginSection())
        loginController.delegate = self
        return loginController
    }()
    
    private lazy var messageSection: MessageSection = {
        return MessageSection(buttonTitle: "Abrir MEI", messageText: "Verificamos que agora você já pode ser MEI", sectionImage: Images.womanReading)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        installChild(loginController)
        self.view.backgroundColor = .clear
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
//                self.showPreForm()
//                self.loginController.verifyViewModel = CPFVerifyViewModel(model: .init(status: "newUser"), cpf: "18004906745")
            }
        }
    }
    
    private func perform(request: AYURequest) {
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<Login>?, validation) in
            DispatchQueue.main.async {
                if let validation = validation {
                    let model = PasswordValidationViewModel(model: validation)
                } else if let result = result?.response  {
                    let session = SessionModel(acessToken: result.accessToken, refreshToken: result.refreshToken)
                    
                    SessionManager.shared.authToken = session.acessToken
                    SessionManager.shared.refreshToken = session.refreshToken
                    
                    self.fetchProfile()
                }
            }
        }
    }
    
//    private func fetchForm() {
//        NetworkManager.shared.makeRequest(request: .init(stringURL: "https://run.mocky.io/v3/a3c092f8-be92-4777-a8ce-56278fd27f2f")) { (result: Handler<Login>?, valid) in
//            print(result)
//        }
//    }
    
    private func fetchProfile() {
        guard let profileID = SessionManager.shared.profileId else {
            return
        }

        let request = AYURoute(path: .profile(id: profileID)).resquest
        
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<ProfileParsable>?, validation) in
            
            DispatchQueue.main.async {
                self.loginController.actionButton.status = .loaded
            }
            
            guard let profile = result?.response else {
                return
            }

            SessionManager.shared.saveAccount(profile: profile)
            
            // show form or home if needed
            
            if true {
                self.showPreForm()
            } else {
                self.showHome()
            }
        }
    }
    
    private func showPreForm() {
        DispatchQueue.main.async {
            self.view.isHidden = true
            let homeFlow = OnboardingMessageViewController(section: self.messageSection)
            homeFlow.modalPresentationStyle = .fullScreen
            self.present(homeFlow, animated: true, completion: nil)
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

extension LoginFlowController: LoginScreenControllerDelegate {
    func loginScreenControllerDelegateRegisterPassword(field: FormFieldContent) {
        guard let passwordValue = field.value, let cpfvalue = loginController.verifyViewModel?.cpf else {
            return
        }
        
        let path = AYURoute.AyuPath.signUP(cpf: cpfvalue, password: passwordValue)
        let request = AYURoute.init(path: path).resquest
                
        perform(request: request)
    }
    
    func loginScreenControllerDelegateLogin(field: FormFieldContent) {
        guard let passwordValue = field.value, let cpfvalue = loginController.verifyViewModel?.cpf else {
            return
        }
        
        let path = AYURoute.AyuPath.login(cpf: cpfvalue, password: passwordValue)
        let request = AYURoute(path: path).resquest
        
        perform(request: request)
    }
    
    func loginScreenControllerDelegateVerifyCPF(field: FormFieldContent) {
        verifyCPF(text: field.value)
    }
}

struct MessageSection: OnboardingFormSection {
    var sectionImageURL: String? = nil
    var layout: FormLayout? = DefaultFormCollectionLayout()
    var buttonTitle: String
    var imagePosition: UIStackView.Alignment = .trailing
    var messageText: String
    var sectionImage: UIImage?
}

struct LoginSection: FormSection {
    var sectionImageURL: String? = nil
    var layout: FormLayout? = DefaultFormCollectionLayout()
    var masks: [MaskField] = []
    var sectionImage: UIImage? = Images.womanWithComputer
}
