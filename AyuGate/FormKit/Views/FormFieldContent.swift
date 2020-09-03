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
    public var textDidChange: ((String) -> Void)?
    
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
        let spacingAfterTitle: CGFloat
        
        public init(placeholder: String? = nil, title: String, value: String? = nil, spacingAfterTitle: CGFloat = 30) {
            self.placeholder = placeholder
            self.title = title
            self.value = value
            self.spacingAfterTitle = spacingAfterTitle
        }
    }
    
    public enum FieldType: String {
        case text
        case upload
    }
    
    public enum Keyboard: String {
        case number
        case `default`
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupTextField()
        updateUI()
    }
    
    func setCustonTitleSpace(_ spacing: CGFloat) -> Self {
        contentStack.spacing = spacing
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
        textFieldPlaceholder.isHidden = model.value != nil && !(model.value?.isEmpty ?? true)
       
        switch maskField.keyboardType {
        case .default:
            textField.keyboardType = .default
        case .number:
            textField.keyboardType = .numberPad
        }
        
        textField.isSecureTextEntry = maskField.isSecurity
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        shouldUpExtraSize = true
    }
    
    private var shouldUpExtraSize: Bool = true
}

extension FormFieldContent: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldPlaceholder.isHidden = true
        fieldIsValid = true
        
        if textField.isSecureTextEntry, shouldUpExtraSize {
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
                UIView.animate(withDuration: 0.3) {
                    self.shouldUpExtraSize = false
                    UIApplication.shared.keyWindow?.frame.origin.y -= 40
                    // refatorar essa gambeta no futuro
                }
            }
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textField = textField as? JMMaskTextField else { return false }
        textField.maskString = maskField.mask
        fieldIsValid = true
        
        var textFieldValue = textField.text
        textFieldValue?.append(string)
        guard let value = textFieldValue else { return true }
        
        guard let mask = maskField.mask, textField.text?.count != mask.count else {
            self.textDidChange?(value)
            return true
        }
        
        self.textDidChange?(value)
        
        return true
    }
    
    private func executValidator(for value: String) {
        guard maskField.validatorQuery != nil else { return }
        let context = JSContext()
        context?.evaluateScript(maskField.validatorQuery)
        
        let validObject = context?.objectForKeyedSubscript("validate")
        let result = validObject?.call(withArguments: [value])
        
        do {
            guard let resultDictionary = result?.toDictionary() else { return }
            let data = try JSONSerialization.data(withJSONObject: resultDictionary, options: .fragmentsAllowed)
            let validation = try JSONDecoder().decode(Validation.self, from: data)
            
            errorMessageLabel.text = validation.message
            fieldIsValid = validation.isValid
            
        } catch {
            validationHandler?(false)
        }
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.textFieldPlaceholder.isHidden = !(textField.text?.isEmpty ?? true)
        executValidator(for: textField.text ?? "")
        return true
    }
}

struct Validation: Decodable {
    let isValid: Bool
    let message: String?
}
