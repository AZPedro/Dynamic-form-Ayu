//
//  Shakeable.swift
//  AyuKit
//
//  Created by Pedro Azevedo on 27/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol Shakeable {
    
    var layer: CALayer { get }
    
    func shake(with duration: TimeInterval)
    
}

extension Shakeable {
    
    public func shake(with duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            
            let anim = CAKeyframeAnimation(keyPath: "transform")
            
            anim.values = [
                NSValue(caTransform3D:CATransform3DMakeTranslation(-3.0, 0, 0)),
                NSValue(caTransform3D:CATransform3DMakeTranslation(3.0, 0, 0))
            ]
            
            anim.autoreverses = true
            anim.repeatCount = 1
            anim.duration = 0.1
            
            self.layer.add(anim, forKey: nil)
        })
    }
    
}

extension UIView: Shakeable { }
