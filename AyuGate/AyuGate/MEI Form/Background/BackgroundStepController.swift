//
//  BackgroundStepController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 08/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol BackgroundStepViewProtocol: StepProtocol, UIViewController {
    var backgroundImagesView: [UIImageView] { get set }
    var contantByPosition: [CGFloat] { get set }
    var backgroundImageViewRightContant: CGFloat { get set }
    var bacgroundImageviewCenterXAnchorConstraint: NSLayoutConstraint? { get set }
}

protocol StepProtocol {
    var numberOfSteps: Int { get set }
    var currentStep: Int { get set }
    func moveToStep(at position: Int)
}

extension BackgroundStepViewProtocol {
    
    var defaultConstant: CGFloat {
        return UIScreen.main.bounds.width * 0.6
    }
    
    func setup() {
        view.backgroundColor = .formBackgroundColor
        
        prepareBackgroundImages()
        prepareConstantsByPosition()
        setupImagesPositions()
    }
    
    private func prepareBackgroundImages() {
        var i = 0
        
        while i < numberOfSteps {
            i += 1
            backgroundImagesView.append(UIImageView())
        }
    }
    
    private func prepareConstantsByPosition() {
        var i = 0
        var constant: CGFloat = defaultConstant
        
        while i < numberOfSteps {
            contantByPosition.append(constant)
            i += 1
            constant += 200
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
        let initialConstantPosition = currentStep != 0 ? (-contantByPosition[currentStep]) : contantByPosition[currentStep]
        bacgroundImageviewCenterXAnchorConstraint = backgroundImagesView.first?.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: initialConstantPosition)
        bacgroundImageviewCenterXAnchorConstraint?.isActive = true
    }
    
    func updateContant() {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.bacgroundImageviewCenterXAnchorConstraint?.constant = self.backgroundImageViewRightContant
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

class BackgroundStepController: UIViewController, BackgroundStepViewProtocol {
    var contantByPosition: [CGFloat] = []
    var backgroundImagesView: [UIImageView] = []
    var bacgroundImageviewCenterXAnchorConstraint: NSLayoutConstraint?
   
    var backgroundImageViewRightContant: CGFloat = 0 {
        didSet {
            updateContant()
        }
    }
    
    var numberOfSteps: Int
    var currentStep: Int
    
    init(numberOfSteps: Int, currentStep: Int) {
        self.numberOfSteps = numberOfSteps
        self.currentStep = currentStep
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

    private func buildUI() {
        setup()
    }
    
    func moveToStep(at position: Int) {
        let constant = position > currentStep ? (-contantByPosition[position]) : contantByPosition[position]
        backgroundImageViewRightContant = constant
        currentStep = position
    }
}
