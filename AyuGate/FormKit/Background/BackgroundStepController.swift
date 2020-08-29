//
//  BackgroundStepController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 08/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import CHIPageControl
import AyuKit

protocol BackgroundStepViewProtocol: StepProtocolDelegate, UIViewController {
    var stepDependence: StepProtocol { get set }
    var backgroundImagesView: [UIImageView] { get set }
    var backgroundImageViewRightContant: CGFloat { get set }
    var bacgroundImageviewCenterXAnchorConstraint: NSLayoutConstraint? { get set }
}

public protocol StepProtocolDelegate {
    func moveToStep(at position: Int)
}

extension BackgroundStepViewProtocol {
    
    var defaultConstant: CGFloat {
        return UIScreen.main.bounds.width * 0.6
    }
    
    func setup() {
        view.backgroundColor = .formBackgroundColor
        
        prepareBackgroundImages()
        backgroundImageViewRightContant = defaultConstant
        setupImagesPositions()
    }
    
    private func prepareBackgroundImages() {
        var i = 0
        
        while i < stepDependence.numberOfSteps {
            i += 1
            backgroundImagesView.append(UIImageView())
        }
    }
    
    private func setupImagesPositions() {
        backgroundImagesView.enumerated().forEach({ (index, backgroundImageView) in
            view.addSubview(backgroundImageView)
            backgroundImageView.image = Images.ayuYbackground
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
            backgroundImageView.set(width: UIScreen.main.bounds.width * 1.2, height: UIScreen.main.bounds.height * 0.9)
            backgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: UIScreen.main.bounds.height * -0.1).isActive = true
            
            if index != 0 {
                backgroundImageView.leadingAnchor.constraint(equalTo: backgroundImagesView[index-1].trailingAnchor, constant: 190).isActive = true
            }
        })
        
        backgroundImagesView.first?.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: UIScreen.main.bounds.height * -0.1).isActive = true
        bacgroundImageviewCenterXAnchorConstraint = backgroundImagesView.first?.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: defaultConstant)
        bacgroundImageviewCenterXAnchorConstraint?.isActive = true
    }
    
    func updateContant() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.bacgroundImageviewCenterXAnchorConstraint?.constant = self.backgroundImageViewRightContant
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

public class BackgroundStepController: UIViewController, BackgroundStepViewProtocol {
    
    var backgroundImagesView: [UIImageView] = []
    var bacgroundImageviewCenterXAnchorConstraint: NSLayoutConstraint?
   
    var backgroundImageViewRightContant: CGFloat = 0 {
        didSet {
            updateContant()
        }
    }
    
    internal var stepDependence: StepProtocol
    
    public init(stepDependence: StepProtocol) {
        self.stepDependence = stepDependence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

    private func buildUI() {
        setup()
    }
    
    public func moveToStep(at position: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let constant = position > self.stepDependence.currentStep ? self.backgroundImageViewRightContant-self.defaultConstant : self.backgroundImageViewRightContant+self.defaultConstant
            self.backgroundImageViewRightContant = constant
            self.stepDependence.currentStep = position
        }
    }
}
