//
//  StepPageControlViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import CHIPageControl

class StepPageControlViewController: UIViewController, StepProtocolDelegate {
    let pageControl = CHIPageControlAleppo()
    let feedbackImpact = UIImpactFeedbackGenerator(style: .light)
    
    internal var stepDependence: StepProtocol

    init(stepDependence: StepProtocol) {
        self.stepDependence = stepDependence
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
        
        pageControl.numberOfPages = stepDependence.numberOfSteps+1
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
