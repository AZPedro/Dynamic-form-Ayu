//
//  HomeFlowController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 21/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class HomeFlowController: UIViewController {
    
    private lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController()
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        installChild(homeViewController)
    }
}
