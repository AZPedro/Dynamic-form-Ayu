//
//  StepPageControlViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import CHIPageControl

class StepPageControlViewController: UIViewController, StepProtocol {
    let pageControl = CHIPageControlAleppo()
    let feedbackImpact = UIImpactFeedbackGenerator(style: .light)
    
    var numberOfSteps: Int
    var currentStep: Int = 0 {
        didSet {
            moveToStep(at: currentStep)
        }
    }

    init(numberOfSteps: Int) {
        self.numberOfSteps = numberOfSteps
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.add(view: pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalToConstant: 100),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view.widthAnchor.constraint(equalTo: pageControl.widthAnchor),
            view.heightAnchor.constraint(equalTo: pageControl.heightAnchor)
        ])
        
        pageControl.numberOfPages = numberOfSteps+1
        pageControl.radius = 4
        pageControl.tintColor = .formBackgroundSecondaryColor
        pageControl.currentPageTintColor = .white
        pageControl.padding = 8
    }
    
    func moveToStep(at position: Int) {
        pageControl.set(progress: position, animated: true)
        feedbackImpact.impactOccurred()
    }
}
