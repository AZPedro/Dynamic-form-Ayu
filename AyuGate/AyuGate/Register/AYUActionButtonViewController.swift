//
//  AYUActionButtonViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

protocol AYUActionButtonViewControllerDelegate: AYUActionButtonViewController {
    var controllerUpConstant: CGFloat? { get }
}

class AYUActionButtonViewController: AYUViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var actionHandler: (() -> Void)?
    public var actionButtonViewControllerDelegate: AYUActionButtonViewControllerDelegate?
    
    private func buildUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(actionButton)
        
        actionButtonBottomConstraint = actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        actionButtonBottomConstraint?.isActive = true
        actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(_ sender: Any) {
        actionHandler?()
    }

    lazy var actionButton: AYUActionButton = {
        let button = AYUActionButton().setTitle("Avançar")
        return button
    }()
    
    var actionButtonBottomConstraint: NSLayoutConstraint?
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.setNeedsLayout()
            
            guard UIApplication.shared.keyWindow?.frame.origin.y == 0 else {
                return
            }

            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                let upConstant = self.actionButtonViewControllerDelegate?.controllerUpConstant ?? 0
                UIApplication.shared.keyWindow?.frame.origin.y -= upConstant
                self.actionButtonBottomConstraint?.constant = -keyboardSize.height + upConstant - 15
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        view.setNeedsLayout()

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.actionButtonBottomConstraint?.constant = 0
            UIApplication.shared.keyWindow?.frame.origin.y = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
