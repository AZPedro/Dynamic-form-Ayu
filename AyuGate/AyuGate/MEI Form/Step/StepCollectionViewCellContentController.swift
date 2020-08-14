//
//  StepCollectionViewCellContentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class StepCollectionViewCellContentController: UIViewController {
    
    let redView = UIView().set(width: 100, height: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        view.addSubview(redView)
        redView.backgroundColor = .red
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
