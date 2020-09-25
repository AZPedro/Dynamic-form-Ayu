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
import UserNotifications

class LoginFlowController: UIViewController {
    
    let network = NetworkManager()
    
    private lazy var loginController: LoginScreenController = {
        let loginController = LoginScreenController(section: LoginFormSection())
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
        PermissionsManager.shared.requestNotification()
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
//                self.l3oginController.verifyViewModel = CPFVerifyViewModel(model: .init(status: "newUser"), cpf: "18004906745")
            }
        }
    }
    
    private func perform(request: AYURequest) {
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<Login>?, validation) in
            DispatchQueue.main.async {
                if let validation = validation {
                    self.loginController.actionButton.status = .loaded
                    self.loginController.fieldContent.fieldIsValid = false
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
            self.sendPushToken()
            
            if profile.cpf == "07988032151" {
                self.showHome()
            } else {
                self.showPreForm()
            }
        }
    }
    
    private func sendPushToken() {
        guard let token = SessionManager.shared.pushToken else { return }
        let request = AYURoute(path: .pushToken(token: token)).resquest
        
        NetworkManager.shared.makeRequest(request: request) { (result: Handler<Push>?, validation) in}
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
            let navigationController = UINavigationController(rootViewController: HomeFlowController())
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
            
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
//    private func askNotificationIfNeeded() {
//
//        let center = UNUserNotificationCenter.current()
//
//        center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { granted, error in
//
//            if let error = error {
//                // Handle the error here.
//            }
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//        }
//    }
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

//struct LoginSection: FormSection {
//    var sectionImageURL: String? = nil
//    var layout: FormLayout? = DefaultFormCollectionLayout()
//    var masks: [MaskField] = []
//    var sectionImage: UIImage? = Images.womanWithComputer
//}

