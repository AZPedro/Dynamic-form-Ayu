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
    }
    
    private lazy var headerContentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.yellowPrimary
        v.clipsToBounds = false
        v.layer.cornerRadius = 26
        v.heightAnchor.constraint(equalToConstant: Constants.headerHeight).isActive = true
        
        let logoutLabel = UILabel()
        v.addSubview(logoutLabel)
        logoutLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        logoutLabel.translatesAutoresizingMaskIntoConstraints = false
        logoutLabel.text = "SAIR"
        logoutLabel.topAnchor.constraint(equalTo: v.topAnchor, constant: 41).isActive = true
        logoutLabel.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -17).isActive = true
        
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
    
    private func buildUI() {
        view.backgroundColor = .white
        view.addSubview(headerContentView)
        headerContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: -26).isActive = true
    }
    
    @objc private func pop() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
