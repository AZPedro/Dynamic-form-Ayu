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
    
    func flow() -> UIViewController {
        guard isUserLoged else {
            return unloggedFlow()
        }
        
        return loggedFLow()
    }
    
    func unloggedFlow() -> UIViewController {
        return RegisterFlowController()
    }
    
    func loggedFLow() -> UIViewController {
        return DebugComponentsViewController()
    }
}
