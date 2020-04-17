//
//  AYUViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUViewController: UIViewController {
    
    private lazy var headerLogoImage: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 53).isActive = true
        i.widthAnchor.constraint(equalToConstant: 119).isActive = true
        i.contentMode = .scaleAspectFit
        i.image = UIImage(named: "AYUTitleLogo")
        return i
    }()
    
    private lazy var backArrow: UIImageView = {
        let i = UIImageView()
        i.isUserInteractionEnabled = true
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 28).isActive = true
        i.widthAnchor.constraint(equalToConstant: 15).isActive = true
        i.contentMode = .scaleAspectFit
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pop)))
        i.image = UIImage(named: "backArrow")
        return i
    }()
    
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        view.isUserInteractionEnabled = true
       
        view.backgroundColor = .white
        view.addSubview(headerLogoImage)
        view.addSubview(backArrow)
        
        headerLogoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        backArrow.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        backArrow.centerYAnchor.constraint(equalTo: headerLogoImage.centerYAnchor).isActive = true
    }
}
