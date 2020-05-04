//
//  UIView+extensions.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func installChild(_ viewController: UIViewController) {
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }

}

extension CALayer {
    func setupShadow(opacity: Float = 0.8) {
        masksToBounds = false
        shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        shadowOffset = CGSize(width: 5, height: 7)
        shadowOpacity = opacity
    }
}
