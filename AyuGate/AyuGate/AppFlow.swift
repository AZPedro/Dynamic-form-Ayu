//
//  AppFlow.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

final class AppFlow: NSObject {
    
    static var shared: AppFlow = AppFlow()
    
    let isUserLoged: Bool = false
    
    private lazy var nav = UINavigationController()
    
    func flow() -> UINavigationController {
        nav.isNavigationBarHidden = true
        
        if isUserLoged {
            nav.viewControllers = [UIViewController()]
        } else {
//            nav.viewControllers = [DebugComponentsViewController()]
//            nav.viewControllers = [HomeFlowController()]
            nav.viewControllers = [RegisterFlowController()]
        }
        
        return nav
    }
}
