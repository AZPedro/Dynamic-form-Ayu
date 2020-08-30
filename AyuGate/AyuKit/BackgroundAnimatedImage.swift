//
//  BackgroundAnimatedImage.swift
//  AyuKit
//
//  Created by Pedro Azevedo on 29/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol BackgroundAnimatedImage: UIViewController {
    var imageView: UIImageView { get set }
    var section: FormSection { get set }
    func animateBackgroundImage(duration: Double, withDelay: Double)
    var initialImageFrame: CGRect { get set }
}

extension BackgroundAnimatedImage {
    public func prepare() {
        imageView.alpha = 0
        initialImageFrame = imageView.frame
        let initialXPosition = section.imagePosition == .left ? -(imageView.frame.width-10) : +(imageView.frame.width+10)
        imageView.frame = .init(x: initialXPosition, y: imageView.frame.origin.y, width: imageView.frame.width, height: imageView.frame.height)
    }
    
    public func animateBackgroundImage(duration: Double = 0.3, withDelay: Double = 0.9) {
        if initialImageFrame == .zero {
            assertionFailure("prepare() function shoud be called on layoutSubviews")
        }

        UIView.animate(withDuration: duration, delay: withDelay, options: .curveEaseInOut, animations: {
            self.imageView.alpha = 1
            self.imageView.frame = self.initialImageFrame
        }) { finished in
            
        }
    }
}
