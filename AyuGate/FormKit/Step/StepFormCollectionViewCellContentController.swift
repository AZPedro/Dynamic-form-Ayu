//
//  StepCollectionViewCellContentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

public class StepFormCollectionViewCellContentController: AYUActionButtonViewController, AYUActionButtonViewControllerDelegate {
    public var controllerUpConstant: CGFloat? = 100

    public var section: FormSection
    
    private lazy var scrollContentView: UIScrollView = {
        let scrollContentView = UIScrollView()
        scrollContentView.contentSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*2)
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        return scrollContentView
    }()
    
    public var initialImageFrame: CGRect = .zero
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: section.sectionImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackFieldsContent: UIStackView = {
        let stackView = UIStackView().vertical(20)

        stackView.translatesAutoresizingMaskIntoConstraints = false
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

        scrollContentView.addSubview(imageView)
        scrollContentView.addSubview(stackFieldsContent)
    
    
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            scrollContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 154),
            imageView.heightAnchor.constraint(equalToConstant: 233),
                    
            stackFieldsContent.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            stackFieldsContent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackFieldsContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-44),
        ])
        
        switch section.imagePosition {
        case .right:
            imageView.rightAnchor.constraint(equalTo: scrollContentView.rightAnchor, constant: section.imageBorderSpace).isActive = true
        default:
            imageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: section.imageBorderSpace).isActive = true
        }
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        actionButton.isHidden = true
        actionButtonViewControllerDelegate = self
        
        setupFields()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupFields() {
        var fields = section.masks.compactMap { mask -> FormFieldContent? in
            let formField = FormFieldContent(maskField: mask)
            formField.model = mask.formModel
            return formField
        }
        
        if fields.count > 1 {
            fields = fields.map({
                $0.setCustonTitleSpace(10)
            })
        }
        
        stackFieldsContent.add(fields)
    }
}
