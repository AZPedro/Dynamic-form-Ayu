//
//  AYUViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

open class AYUViewController: UIViewController {
    
    lazy var headerLogoImage: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 40).isActive = true
        i.widthAnchor.constraint(equalToConstant: 120).isActive = true
        i.contentMode = .scaleAspectFit
        i.image = UIImage(named: "AYUTitleLogo")
        return i
    }()
     
    public lazy var backArrow: UIImageView = {
        let i = UIImageView()
        i.isHidden = true
        i.isUserInteractionEnabled = true
        i.translatesAutoresizingMaskIntoConstraints = false
        i.heightAnchor.constraint(equalToConstant: 28).isActive = true
        i.widthAnchor.constraint(equalToConstant: 28).isActive = true
        i.contentMode = .scaleAspectFit
        i.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pop)))
        i.image = UIImage(named: "backArrow")
        return i
    }()
    
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        view.isUserInteractionEnabled = true
       
        view.backgroundColor = .clear
        view.addSubview(headerLogoImage)
        view.addSubview(backArrow)
        
        headerLogoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        backArrow.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        backArrow.centerYAnchor.constraint(equalTo: headerLogoImage.centerYAnchor).isActive = true
    }
}
