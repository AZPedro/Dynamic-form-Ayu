//
//  StepCollectionViewCellContentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

protocol SectionController: UIViewController {
    var imageView: UIImageView { get set }
    var delegate: StepCollectionViewCell? { get set }
}

public class StepFormCollectionViewCellContentController: AYUActionButtonViewController, AYUActionButtonViewControllerDelegate, SectionController {
    
    public var section: FormSection
    var delegate: StepCollectionViewCell?
    public var controllerUpConstant: CGFloat? = 100
    private var formFieldsContents: [FormFieldContent] = []
    
    private lazy var scrollContentView: UIScrollView = {
        let scrollContentView = UIScrollView()
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.showsVerticalScrollIndicator = false
        return scrollContentView
    }()
    
    public var initialImageFrame: CGRect = .zero
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: section.sectionImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var closeButton: UIImageView = {
        let backArrow = UIImageView()
        backArrow.isUserInteractionEnabled = true
        backArrow.translatesAutoresizingMaskIntoConstraints = false
        backArrow.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backArrow.widthAnchor.constraint(equalToConstant: 28).isActive = true
        backArrow.contentMode = .scaleAspectFit
        backArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissForm)))
        backArrow.image = UIImage(named: "CloseButtonIcon")
        return backArrow
    }()
    
    private lazy var mainStackContent: UIStackView = {
        let stackView = UIStackView().vertical(50)
        switch section.imagePosition {
        
        case .trailing:
            stackView.alignment = .trailing
        default:
            stackView.alignment = .leading
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackFieldsContent: UIStackView = {
        let stackView = UIStackView().vertical(20)
        stackView.alignment = .leading
        return stackView
    }()
    
    public init(section: FormSection) {
        self.section = section
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        view.addSubview(scrollContentView)
        view.addSubview(closeButton)

        scrollContentView.addSubview(mainStackContent)
        
        mainStackContent.add([
            imageView,
            stackFieldsContent
        ])
    
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            scrollContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       
            mainStackContent.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 80),
            mainStackContent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-44),
            mainStackContent.bottomAnchor.constraint(lessThanOrEqualTo: scrollContentView.bottomAnchor, constant: -30),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        actionButton.isHidden = true
        actionButtonViewControllerDelegate = self
        
        setupFields()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupFields() {
        var fields = section.masks.enumerated().compactMap { index, mask -> FormFieldContent? in
            let formField = FormFieldContent(maskField: mask)
            formField.model = mask.formModel
            
            formField.validationSectionHandler = { _ in
                self.section.masks[index].formModel.value = formField.value
                self.checkAllFieldsValidation()
            }
            
            return formField
        }
        
        if fields.count > 1 {
            fields = fields.map({
                $0.setCustonTitleSpace(10)
            })
        }
        formFieldsContents = fields
        stackFieldsContent.add(fields)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.section.layout?.shouldShowNextStepButton = true
//            self.section.layout?.delegate?.updateLayout(for: self.section.layout!)
        }
    }
    
    @objc private func dismissForm() {
        self.delegate?.dismissForm()
    }
    
    private func checkAllFieldsValidation() {
        let isAllFieldsValid = self.formFieldsContents.filter({ !$0.fieldIsValid }).isEmpty
        section.layout?.shouldShowNextStepButton = isAllFieldsValid
        self.delegate?.sectionValidationHandler?(section)
    }
    
    var keyboardingIShowing =  false
    public override func keyboardWillHide(notification: Notification) {
        if keyboardingIShowing {
            scrollContentView.contentSize.height = imageView.frame.height + stackFieldsContent.frame.height + 100
            keyboardingIShowing = false
        }
    }
    
    public override func keyboardWillShow(notification: Notification) {
        if !keyboardingIShowing {
            scrollContentView.contentSize.height += 180
            keyboardingIShowing = true
        }
    }
}
