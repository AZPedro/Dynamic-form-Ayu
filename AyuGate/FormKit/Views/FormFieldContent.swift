//
//  FormTextField.swift
//  FormKit
//
//  Created by Pedro Azevedo on 17/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import JMMaskTextField_Swift
import JavaScriptCore

public class FormFieldContent: UIView {

    private var maskField: MaskField
    
    let contentStack = UIStackView().vertical(30)
    let title = UILabel()
        .font(.systemFont(ofSize: 22, weight: .bold))
        .textColour(UIColor.white)
    
    let textFieldPlaceholder = UILabel()
        .font(.systemFont(ofSize: 13, weight: .medium))
        .textColour(UIColor.textPlaceholderColor)
    
    let textFieldContent = UIView()
    
    public var validationHandler: ((Bool) -> Void)?
    
    @objc private lazy var textField: JMMaskTextField = {
        let textField = JMMaskTextField()
       return textField
    }()
    
    public var value: String? {
        return textField.unmaskedText
    }
    
    public var model: Model? {
        didSet {
            updateUI()
        }
    }

    public struct Model {
        let placeholder: String?
        let title: String
        let value: String?
        let spacingAfterTitle: CGFloat
        
        public init(placeholder: String? = nil, title: String, validator: ((Bool) -> Void)? = nil, value: String? = nil, spacingAfterTitle: CGFloat = 30) {
            self.placeholder = placeholder
            self.title = title
            self.value = value
            self.spacingAfterTitle = spacingAfterTitle
        }
    }
    
    public enum FieldType {
        case text
        case security
    }
    
    public init(maskField: MaskField) {
        self.maskField = maskField
        super.init(frame: .zero)
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
        
        contentStack.setCustomSpacing(maskField.formModel.spacingAfterTitle, after: title)
        setupTextField()
    }
    
    func setCustonTitleSpace(_ spacing: CGFloat) -> Self {
        contentStack.setCustomSpacing(spacing, after: title)
        return self
    }
    
    func setCustonTitleSize(_ size: CGFloat) -> Self {
        title.font = UIFont.systemFont(ofSize: size, weight: .bold)
        return self
    }
    
    private func setupTextField() {
        textFieldContent.add(view: textField, margins: .init(top: 0, left: 13, bottom: 0, right: 13))
        textFieldContent.backgroundColor = .white
        textFieldContent.layer.cornerRadius = 5
        textFieldContent.clipsToBounds = true
        
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        textField.delegate = self
        textField.keyboardType = maskField.keyboardType
        translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(textFieldPlaceholder)
        textFieldPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldPlaceholder.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textFieldPlaceholder.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        
        textField.isSecureTextEntry = maskField.fieldType == .security
    }
    
    private func updateUI() {
        guard let model = self.model else { return }
        textFieldPlaceholder.text = model.placeholder
        title.text = model.title
    }
}

extension FormFieldContent: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldPlaceholder.isHidden = true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.textFieldPlaceholder.isHidden = !(textField.text?.isEmpty ?? true)
    }
       
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let mask = maskField.mask else { return true }
        guard let textField = textField as? JMMaskTextField else { return false }
        textField.maskString = maskField.mask
        
        if let textCount = textField.text?.count, textCount == mask.count-1 {
            guard maskField.validatorQuery != nil else { return true }
            var textFieldValue = textField.text
            textFieldValue?.append(string)
            guard let value = textFieldValue else { return true }
            executValidator(for: value)
        }
        
        return true
    }
    
    private func executValidator(for value: String) {
        let context = JSContext()
        context?.evaluateScript(maskField.validatorQuery)
        
        let validObject = context?.objectForKeyedSubscript("validate")
        let result = validObject?.call(withArguments: [value])
        
        guard let resultDescription = result?.description else {
            return
        }
        
        let isValid = resultDescription == "0"
        validationHandler?(isValid)
        
    }
}
