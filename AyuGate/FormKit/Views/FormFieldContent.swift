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

    public var maskField: MaskField {
        didSet {
            model = maskField.formModel
        }
    }
    
    let contentStack = UIStackView().vertical(30)
    let titleStack = UIStackView().horizontal(12)
    
    public let title = UILabel()
        .font(.systemFont(ofSize: 22, weight: .bold))
        .textColour(UIColor.white)
    
    let textFieldPlaceholder = UILabel()
        .font(.systemFont(ofSize: 13, weight: .medium))
        .textColour(UIColor.textPlaceholderColor)
    
    let errorMessageLabel = UILabel()
        .font(.systemFont(ofSize: 15, weight: .bold))
        .textColour(UIColor.redSecondary)
    
    let textFieldContent = UIView()
    
    public var validationHandler: ((Bool) -> Void)?
    
    @objc private lazy var textField: JMMaskTextField = {
        let textField = JMMaskTextField()
       return textField
    }()
    
    public lazy var titleAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.isHidden = true
        return imageView
    }()
    
    public var value: String? {
        return textField.unmaskedText
    }
    
    public var model: Model? {
        didSet {
            updateUI()
        }
    }
    
    public var fieldIsValid: Bool = true {
        didSet {
            self.errorMessageLabel.isHidden = self.fieldIsValid
        }
    }

    public struct Model {
        let placeholder: String?
        let title: String
        let value: String?
        let errorMessage: String?
        let spacingAfterTitle: CGFloat
        
        public init(placeholder: String? = nil, title: String, validator: ((Bool) -> Void)? = nil, value: String? = nil, spacingAfterTitle: CGFloat = 30, errorMessage: String? = nil) {
            self.placeholder = placeholder
            self.title = title
            self.value = value
            self.spacingAfterTitle = spacingAfterTitle
            self.errorMessage = errorMessage
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

        titleStack.alignment = .leading
        
        titleStack.add([
            title,
            titleAccessoryView
        ])

        contentStack.alignment = .leading
        contentStack.distribution = .fillProportionally
        
        contentStack.add([
            titleStack,
            textFieldContent,
            errorMessageLabel
        ])
        
        contentStack.setCustomSpacing(maskField.formModel.spacingAfterTitle, after: title)
        contentStack.setCustomSpacing(10, after: textFieldContent)
        errorMessageLabel.isHidden = true
        setupTextField()
        updateUI()
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
        textFieldContent.addSubview(textField)
        textFieldContent.backgroundColor = .white
        textFieldContent.layer.cornerRadius = 5
        textFieldContent.clipsToBounds = true
        
        textField.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        textField.textColor = UIColor.blackSecondary
        translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(textFieldPlaceholder)
        textFieldPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldContent.heightAnchor.constraint(equalToConstant: 38),
            textFieldContent.widthAnchor.constraint(equalToConstant: 333),
            textField.leadingAnchor.constraint(equalTo: textFieldContent.leadingAnchor, constant: 13),
            textField.trailingAnchor.constraint(equalTo: textFieldContent.trailingAnchor, constant: -13),
            textField.topAnchor.constraint(equalTo: textFieldContent.topAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldContent.bottomAnchor),
            
            textFieldPlaceholder.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            textFieldPlaceholder.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
        ])
    }
    
    private func updateUI() {
        guard let model = self.model else { return }
        textFieldPlaceholder.text = model.placeholder
        title.text = model.title
        textField.text = model.value
        textField.maskString = maskField.mask
        errorMessageLabel.text = model.errorMessage
        textFieldPlaceholder.isHidden = model.value != nil
        textField.keyboardType = maskField.keyboardType
        textField.isSecureTextEntry = maskField.fieldType == .security
    }
}

extension FormFieldContent: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        UIApplication.shared.keyWindow?.frame.origin.y = 0
        textFieldPlaceholder.isHidden = true
        fieldIsValid = true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? JMMaskTextField else { return false }
        textField.maskString = maskField.mask
        fieldIsValid = true
        guard let mask = maskField.mask, textField.text?.count != mask.count else { return true }
    
        guard maskField.validatorQuery != nil else { return true }
        var textFieldValue = textField.text
        textFieldValue?.append(string)
        
        guard let value = textFieldValue else { return true }
        executValidator(for: value)

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
        
        if value.count == maskField.mask?.count {
            fieldIsValid = isValid
        }
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.textFieldPlaceholder.isHidden = !(textField.text?.isEmpty ?? true)
        return true
    }
}
