//
//  AYUTextField.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation
import UIKit

class AYUTextField: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    struct Constants {
        static var lineHeight: CGFloat = 1
        static var lineWidth: CGFloat = 278
        static var viewHeight: CGFloat = 70
        static var viewExpandedHeight: CGFloat = 100
        static var textFieldHeight: CGFloat = 40
    }
    
    enum State {
        case valid
        case failed
        case input
        case notInputed
    }
    
    var isExpanded: Bool = false
    
    lazy var textField: UITextField = {
        let t = UITextField()
        t.tintColor = .black
        t.delegate = self
        t.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textFieldDidtouched)))
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    var titleLabel: UILabel = {
        let t = UILabel()
        t.text = "Cadastro com seu CPF"
        t.textAlignment = .left
        t.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.textColor = .black
        return t
    }()
    
    var placeHolder: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "CPF"
        l.textColor = UIColor.blackSecondary
        l.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return l
    }()
    
    private var backLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()
    
    private var errorLabel: UILabel = {
        let l = UILabel()
        l.alpha = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Não foi possivel encontrar o CPF inserido"
        l.textColor = UIColor.error
        l.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return l
    }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    private func buildUI() {
        addSubview(titleLabel)
        addSubview(placeHolder)
        addSubview(textField)
        addSubview(backLine)
        addSubview(errorLabel)
        
        heightConstraint = heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        heightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            textField.trailingAnchor.constraint(equalTo: backLine.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: backLine.topAnchor),
            
            placeHolder.leadingAnchor.constraint(equalTo: backLine.leadingAnchor),
            placeHolder.centerYAnchor.constraint(equalTo: textField.centerYAnchor),

            backLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            backLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backLine.widthAnchor.constraint(equalToConstant: Constants.lineWidth),
            backLine.heightAnchor.constraint(equalToConstant: Constants.lineHeight),
            
            errorLabel.leadingAnchor.constraint(equalTo: backLine.leadingAnchor),
            errorLabel.topAnchor.constraint(equalTo: backLine.bottomAnchor, constant: 9),
            errorLabel.trailingAnchor.constraint(equalTo: backLine.trailingAnchor)
        ])
        
        textField.textColor = .black
    }

    func updateState(state: State) {
        switch state {
        case .failed:
            animateError(shouldShow: true)
            expandedAnimation(shouldExpand: true)
        case .valid:
            backLine.backgroundColor = .black
        case .input:
            animatePlaceholder(shouldShow: false)
            animateError(shouldShow: false)
            expandedAnimation(shouldExpand: false)
        case .notInputed:
            guard let text = textField.text, text.isEmpty else { return }
            animatePlaceholder(shouldShow: true)
        }
    }
    
    func animatePlaceholder(shouldShow: Bool) {
        guard shouldShow || !shouldShow && placeHolder.alpha != 0 else { return }
        
        placeHolder.alpha = shouldShow ? 0 : 1
        setNeedsLayout()
        UIView.animate(withDuration: 0.5) {
            self.placeHolder.alpha = shouldShow ? 1 : 0
            self.layoutIfNeeded()
        }
    }
    
    func animateError(shouldShow: Bool) {
        guard shouldShow || !shouldShow && errorLabel.alpha != 0 else { return }
       
        errorLabel.alpha = shouldShow ? 0 : 1
        backLine.backgroundColor = shouldShow ? .black : .error
        
        setNeedsLayout()
        UIView.animate(withDuration: 0.5) {
            self.errorLabel.alpha = shouldShow ? 1 : 0
            self.backLine.backgroundColor = shouldShow ? UIColor.error : UIColor.black
            self.heightConstraint?.constant = Constants.viewExpandedHeight
            self.layoutIfNeeded()
        }
    }
    
    func expandedAnimation(shouldExpand: Bool) {
        setNeedsLayout()
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint?.constant = shouldExpand ? Constants.viewExpandedHeight : Constants.viewHeight
            self.layoutIfNeeded()
        }
    }
}

extension AYUTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateState(state: .input)
    }
    
    @objc func textFieldDidtouched(_ textField: UITextField) {
        updateState(state: .input)
        self.textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.updateState(state: .notInputed)
        return true
    }
    
}
