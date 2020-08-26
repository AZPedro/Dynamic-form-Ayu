//
//  AYUFormViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 17/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUActionButtonViewController: AYUViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var actionHandler: (() -> Void)?
    
    private func buildUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(actionButton)
        
        actionButtonBottomConstraint = actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        actionButtonBottomConstraint?.isActive = true
        actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(_ sender: Any) {
        actionHandler?()
    }

    lazy var actionButton: AYUButton = {
        let button = AYUButton(title: "")
        button.customTitleLabel.text = "AVANÇAR"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var actionButtonBottomConstraint: NSLayoutConstraint?
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            view.setNeedsLayout()
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.actionButtonBottomConstraint?.constant = -keyboardSize.height
                self.actionButton.actionButtonHeighConstraint?.constant = 55
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        view.setNeedsLayout()

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.actionButtonBottomConstraint?.constant = 0
            self.actionButton.actionButtonHeighConstraint?.constant = AYUButton.Constants.buttonHeight
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
