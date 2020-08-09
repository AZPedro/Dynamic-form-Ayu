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
    
    private lazy var nav = UINavigationController()
    
    func flow() -> UINavigationController {
        nav.isNavigationBarHidden = true
        
        nav.viewControllers = [BackgroundStepController()]
//        if SessionManager.shared.isUserLoged {
//            nav.viewControllers = [HomeFlowController()]
//        } else {
////            nav.viewControllers = [DebugComponentsViewController()]
////            nav.viewControllers = [HomeFlowController()]
//            nav.viewControllers = [RegisterFlowController()]
////            nav.viewControllers = [InvoiceDetailViewController()]
////            nav.viewControllers = [AccountViewController()]
//        }
        
        return nav
    }
}
