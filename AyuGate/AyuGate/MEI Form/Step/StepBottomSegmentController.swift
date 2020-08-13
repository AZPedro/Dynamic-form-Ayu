//
//  StepBottomSegmentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

protocol StepBottomSegmentControllerDelegate {
    func stepBottomSegmentControllerDelegate(didNext: StepBottomSegmentController)
    func stepBottomSegmentControllerDelegate(didBack: StepBottomSegmentController)
}

class StepBottomSegmentController: UIViewController {
    
    private var delegate: StepBottomSegmentControllerDelegate
    
    var isValid: Bool = true {
        didSet {
            updateUI()
        }
    }
   
    init(delegate: StepBottomSegmentControllerDelegate){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Constants {
        static let defaultConstant: CGFloat = 21
        static let viewHeight: CGFloat = 60
    }
    
    private let nextStepLabel = UILabel()
        .font(.systemFont(ofSize: 15, weight: .semibold))
        .textColour(.white)
        .text("Avançar")
        .translatesAutoresizingMaskIntoConstraints(false)
    
    private let backStepLabel = UILabel()
        .font(.systemFont(ofSize: 15, weight: .semibold))
        .textColour(.white)
        .text("Voltar")
        .translatesAutoresizingMaskIntoConstraints(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        setupUI()
        setupGestures()
        updateUI()
    }

    private func setupUI() {
        view.addSubview(nextStepLabel)
        view.addSubview(backStepLabel)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: Constants.viewHeight),
            backStepLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.defaultConstant),
            backStepLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.defaultConstant),
            nextStepLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.defaultConstant),
            nextStepLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.defaultConstant)
        ])
        
        backStepLabel.isUserInteractionEnabled = true
    }
    
    private func setupGestures() {
        nextStepLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nextAction)))
        backStepLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backAction)))
    }
    
    @objc private func backAction(_ sender: Any) {
        delegate.stepBottomSegmentControllerDelegate(didBack: self)
    }
    
    @objc private func nextAction(_ sender: Any) {
        delegate.stepBottomSegmentControllerDelegate(didNext: self)
    }
    
    private func updateUI() {
        nextStepLabel.alpha = isValid ? 1 : 0.2
        nextStepLabel.isUserInteractionEnabled = isValid ? true : false
    }
}
