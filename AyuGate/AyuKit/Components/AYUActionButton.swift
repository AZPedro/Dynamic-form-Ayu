//
//  AYUActionButton.swift
//  AyuKit
//
//  Created by Pedro Azevedo on 27/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

public protocol AYUActionButtonDelegate {
    func actionButtonDelegateDidTouch(_ sender: Any)
    func actionButtonDelegateDisabledButtonDidTouch(_ sender: Any)
}

extension AYUActionButtonDelegate {
    public func actionButtonDelegateDisabledButtonDidTouch(_ sender: Any) { }
}

public class AYUActionButton: UIButton {
    
    public struct Constants {
        public static let defaulsConstants: CGFloat = 20
        public static let buttonHeight: CGFloat = 45
    }
    
    public var delegate: AYUActionButtonDelegate?
    public var actionHandler: (() -> ())?
    
    private lazy var spinnerView: AYUSpinnerView = {
        let spinner = AYUSpinnerView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.heightAnchor.constraint(equalToConstant: 25).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        return spinner
    }()
    
    public var status: Status = .disabled {
        didSet {
            updateUI()
        }
    }
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
   public enum Status {
        case loading
        case loaded
        case disabled
        case enabled
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
        layer.cornerRadius = 5
        titleLabel?.textColor = .white
        titleLabel?.isUserInteractionEnabled = false

        addSubview(spinnerView)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            spinnerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        updateUI()
    }
    
    public func setTitle(_ value: String) -> Self {
        setTitle(value, for: .normal)
        return self
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            switch self.status {
            case .disabled:
                self.alpha = 0.45
            case .enabled:
                self.alpha = 1
            case .loaded:
                self.titleLabel?.isHidden = false
                self.titleLabel?.alpha = 1
                self.spinnerView.isHidden = true
                self.spinnerView.state = .idle
                self.isEnabled = true
            case .loading:
                self.titleLabel?.alpha = 0
                self.isEnabled = false
                self.spinnerView.isHidden = false
                self.spinnerView.state = .spinning
            }
        }
    }
    
    @objc private func actionButton() {
        if self.status == .disabled {
            feedbackGenerator.notificationOccurred(.error)
            shake(with: 0.4)
            delegate?.actionButtonDelegateDisabledButtonDidTouch(self)
        } else {
            actionHandler?()
            delegate?.actionButtonDelegateDidTouch(self)
        }
    }
}
