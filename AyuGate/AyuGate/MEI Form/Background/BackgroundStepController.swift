//
//  BackgroundStepController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 08/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol BackgroundStepViewProtocol: UIViewController {
    var backgroundImagesView: [UIImageView] { get set }
    var numberOfSteps: Int { get set }
    var backgroundImageViewRightContant: CGFloat? { get set }
    var bacgroundImageviewCenterXAnchorConstraint: NSLayoutConstraint? { get set }
}

extension BackgroundStepViewProtocol {
    
    var defaultConstant: CGFloat {
        return UIScreen.main.bounds.width * 0.6
    }
    
    func setup() {
        view.backgroundColor = .formBackgroundColor
        
        prepareBackgroundImages()
        setupImagesPositions()
    }
    
    private func prepareBackgroundImages() {
        var i = 0
        
        while i < numberOfSteps {
            i += 1
            backgroundImagesView.append(UIImageView())
        }
    }
    
    private func setupImagesPositions() {
        backgroundImagesView.enumerated().forEach({ (index, backgroundImageView) in
            view.addSubview(backgroundImageView)
            backgroundImageView.image = UIImage(named: "ayuYbackground")
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            backgroundImageView.set(width: UIScreen.main.bounds.width * 1.2, height: UIScreen.main.bounds.height * 0.9)
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: UIScreen.main.bounds.height * -0.1).isActive = true
            
            if index != 0 {
                backgroundImageView.leadingAnchor.constraint(equalTo: backgroundImagesView[index-1].trailingAnchor, constant: defaultConstant).isActive = true
            }
        })
        
        backgroundImagesView.first?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: UIScreen.main.bounds.height * -0.1).isActive = true
        bacgroundImageviewCenterXAnchorConstraint = backgroundImagesView.first?.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: defaultConstant)
        bacgroundImageviewCenterXAnchorConstraint?.isActive = true
    }
    
    func updateContant() {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.bacgroundImageviewCenterXAnchorConstraint?.constant = self.backgroundImageViewRightContant ?? self.defaultConstant
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

class BackgroundStepController: UIViewController, BackgroundStepViewProtocol {
    
    var backgroundImagesView: [UIImageView] = []
    var bacgroundImageviewCenterXAnchorConstraint: NSLayoutConstraint?
   
    var backgroundImageViewRightContant: CGFloat? {
        didSet {
            updateContant()
        }
    }
    
    var numberOfSteps: Int = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

    private func buildUI() {
        setup()
    }
}
