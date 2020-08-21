//
//  AccountViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 07/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    struct Constants {
        static let headerHeight = UIScreen.main.bounds.height / 2.8
        static var imageSpacing: CGFloat {
            if UIDevice().hasNotch {
                return 5
            } else {
                return 20
            }
        }
    }
    
    private lazy var headerContentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.yellowPrimary
        v.clipsToBounds = false
        v.layer.setupShadow(opacity: 0.5)
        v.layer.cornerRadius = 26
        v.heightAnchor.constraint(equalToConstant: Constants.headerHeight).isActive = true
        
        let logoutLabel = UILabel()
        v.addSubview(logoutLabel)
        logoutLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        logoutLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutLabel.text = "SAIR"
        logoutLabel.isUserInteractionEnabled = true
        logoutLabel.textColor = UIColor.black
        logoutLabel.topAnchor.constraint(equalTo: v.topAnchor, constant: 41).isActive = true
        logoutLabel.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -17).isActive = true
        logoutLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logout)))
        
        let backArrow = UIImageView()
        v.addSubview(backArrow)
        backArrow.isUserInteractionEnabled = true
        backArrow.translatesAutoresizingMaskIntoConstraints = false
        backArrow.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backArrow.widthAnchor.constraint(equalToConstant: 28).isActive = true
        backArrow.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 10).isActive = true
        backArrow.centerYAnchor.constraint(equalTo: logoutLabel.centerYAnchor, constant: 10).isActive = true
        backArrow.contentMode = .scaleAspectFit
        backArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pop)))
        backArrow.image = UIImage(named: "CloseButtonIcon")

        return v
    }()
    
    private lazy var imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "MockedIconProfile")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 88).isActive = true
        
        imageView.layer.cornerRadius = 88 / 2
        return imageView
    }()
    
    private lazy var userImageContenView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        view.clipsToBounds = true
        
        view.heightAnchor.constraint(equalToConstant: 98).isActive = true
        view.widthAnchor.constraint(equalToConstant: 98).isActive = true
        view.layer.cornerRadius = 98 / 2
        
        imageview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vanessa Costa"
        return label
    }()
    
    private lazy var officePositionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Engenharia"
        return label
    }()
    
    private lazy var cpfLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CPF: 180.049.067-45"
        return label
    }()
    
    private lazy var accountDetailsListViewController: AccountDetailsListViewController = {
        let v = AccountDetailsListViewController()
        v.view.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private func buildUI() {
        view.backgroundColor = .white
        view.addSubview(headerContentView)
        headerContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: -26).isActive = true
        
        headerContentView.addSubview(userImageContenView)
        userImageContenView.centerXAnchor.constraint(equalTo: headerContentView.centerXAnchor).isActive = true
        userImageContenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.imageSpacing).isActive = true
        
        headerContentView.addSubview(userNameLabel)
        userNameLabel.topAnchor.constraint(equalTo: userImageContenView.bottomAnchor, constant: 5).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: headerContentView.centerXAnchor).isActive = true
        
        headerContentView.addSubview(officePositionLabel)
        officePositionLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 5).isActive = true
        officePositionLabel.centerXAnchor.constraint(equalTo: headerContentView.centerXAnchor).isActive = true
        
        headerContentView.addSubview(cpfLabel)
        cpfLabel.topAnchor.constraint(equalTo: officePositionLabel.bottomAnchor, constant: 5).isActive = true
        cpfLabel.centerXAnchor.constraint(equalTo: headerContentView.centerXAnchor).isActive = true
        
        view.addSubview(accountDetailsListViewController.view)

        accountDetailsListViewController.view.topAnchor.constraint(equalTo: headerContentView.bottomAnchor, constant: 10).isActive = true
        accountDetailsListViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        accountDetailsListViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        accountDetailsListViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func pop() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func logout() {
        SessionManager.shared.logout()
        
//        let loginFlow = RegisterFlowController()
//        let navigation = UINavigationController(rootViewController: loginFlow)
//        navigation.modalPresentationStyle = .fullScreen
//
//        self.present(navigation, animated: true, completion: {
//            if let count = self.navigationController?.viewControllers.count {
//                let backViewControllerPosition = count - 2
//                guard backViewControllerPosition >= 0 else {
//                    return
//                }
//                self.navigationController?.viewControllers.remove(at: backViewControllerPosition)
//            }
//        })
    }
}
