//
//  FormTextField.swift
//  FormKit
//
//  Created by Pedro Azevedo on 17/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class FormTextField: UIView {
    
    let contentStack = UIStackView().vertical(30)
    let title = UILabel()
        .font(.systemFont(ofSize: 22, weight: .bold))
        .textColour(UIColor.white)
    
    let textFieldPlaceholder = UILabel()
        .font(.systemFont(ofSize: 13, weight: .medium))
        .textColour(UIColor.textPlaceholderColor)
    
    let textFieldContent = UIView()
    let textField = UITextField()
    
    var model: Model? {
        didSet {
            updateUI()
        }
    }
    
    struct Model {
        let placeholder: String?
        let title: String
        let validator: ((Bool) -> Void)?
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        add(view: contentStack)
        
        title.textAlignment = .left

        contentStack.add([
            title,
            textFieldContent
        ])
        
        setupTextField()
    }
    
    private func setupTextField() {
        textFieldContent.add(view: textField, margins: .init(top: 0, left: 13, bottom: 0, right: 13))
        textFieldContent.backgroundColor = .white
        textFieldContent.layer.cornerRadius = 5
        textFieldContent.clipsToBounds = true
        
        textField.delegate = self
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        textField.addSubview(textFieldPlaceholder)
        textFieldPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldPlaceholder.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textFieldPlaceholder.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
    }
    
    private func updateUI() {
        guard let model = self.model else { return }
        textFieldPlaceholder.text = model.placeholder
        title.text = model.title
    }
}

extension FormTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldPlaceholder.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.textFieldPlaceholder.isHidden = !(textField.text?.isEmpty ?? true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
