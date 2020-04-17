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
        static let buttonHeight: CGFloat = 55
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
    
    var handler: (() -> Void)?
    
    func buildUI() {
        addSubview(spinnerView)
        
        setTitleColor(.grayPrimary, for: .disabled)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        titleLabel?.isUserInteractionEnabled = false

        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            spinnerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
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
            titleLabel?.alpha = 1
        case .loading:
            impactFeedback.impactOccurred()
            isUserInteractionEnabled = false
            spinnerView.isHidden = false
            titleLabel?.alpha = 0
            spinnerView.state = .spinning
        case .error:
            notificationFeedback.notificationOccurred(.error)
            isUserInteractionEnabled = true
            spinnerView.isHidden = true
            spinnerView.state = .idle
            titleLabel?.alpha = 1
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
