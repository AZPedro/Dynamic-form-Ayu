//
//  AYUButton.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation
import UIKit

class AYUButton: UIButton {
    
    struct Constants {
        static let buttonHeight: CGFloat = UIDevice().hasNotch ? 75 : 55
        static let widthPadding: CGFloat = 20
    }
    
    let impactFeedback = UIImpactFeedbackGenerator()
    let notificationFeedback = UINotificationFeedbackGenerator()
    
    private lazy var spinnerView: AYUSpinnerView = {
        let spinner = AYUSpinnerView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return spinner
    }()
    
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = isEnabled ? .yellowPrimary : .grayPrimary
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(action(_:))))
        return label
    }()
    
    var handler: (() -> Void)?
    var actionButtonHeighConstraint: NSLayoutConstraint?
    
    func buildUI() {
        addSubview(spinnerView)
        addSubview(customTitleLabel)
        customTitleLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: 27.5).isActive = true
        customTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        translatesAutoresizingMaskIntoConstraints = false
        
        actionButtonHeighConstraint = heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        actionButtonHeighConstraint?.isActive = true
        NSLayoutConstraint.activate([
            spinnerView.centerYAnchor.constraint(equalTo: self.customTitleLabel.centerYAnchor),
            spinnerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        self.addTarget(self, action: #selector(action(_:)), for: .touchUpInside)
        
        updateUI()
    }
    
    enum ButtonState {
        case loading
        case success
        case error
    }
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .black : .graySecondary
            customTitleLabel.textColor = isEnabled ? .yellowPrimary : .grayPrimary
        }
    }
    
    var title: String? {
        didSet {
          updateUI()
        }
    }
    
    var titleColor: UIColor = .yellowPrimary {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        setTitle(title, for: .normal)
        backgroundColor =  isEnabled ? .black : .graySecondary
    }

    @objc private func action(_ sender: Any) {
        updateState(state: .loading)
        handler?()
    }

    func updateState(state: ButtonState) {
        switch state {
        case .success:
            notificationFeedback.notificationOccurred(.success)
            isUserInteractionEnabled = true
            spinnerView.isHidden = true
            spinnerView.state = .idle
            customTitleLabel.alpha = 1
        case .loading:
            impactFeedback.impactOccurred()
            isUserInteractionEnabled = false
            spinnerView.isHidden = false
            customTitleLabel.alpha = 0
            spinnerView.state = .spinning
        case .error:
            notificationFeedback.notificationOccurred(.error)
            isUserInteractionEnabled = true
            spinnerView.isHidden = true
            spinnerView.state = .idle
            customTitleLabel.alpha = 1
        }
    }
}

extension AYUButton {
    public convenience init(title: String, titleColor: UIColor) {
        self.init()
        self.title = title
        self.titleColor = titleColor
        buildUI()
    }
}
