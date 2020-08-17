//
//  AppFlow.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit

final class AppFlow: NSObject {
    
    static var shared: AppFlow = AppFlow()
    
    private lazy var nav = UINavigationController()
    
    func flow() -> UINavigationController {
        nav.isNavigationBarHidden = true
        
//        nav.viewControllers = [FormStepFlowController()]
        if SessionManager.shared.isUserLoged {
            nav.viewControllers = [HomeFlowController()]
        } else {
            nav.viewControllers = [RegisterFlowController()]
        }
        
        return nav
    }
}
