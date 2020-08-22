//
//  StepCollectionViewCellContentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class StepCollectionViewCellContentController: UIViewController {
    
    private var section: FormSection
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: section.sectionImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackFieldsContent: UIStackView = {
        let stackView = UIStackView().vertical(20)
        return stackView
    }()
    
    init(section: FormSection) {
        self.section = section
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        view.addSubview(stackFieldsContent)
        view.addSubview(imageView)
        
        stackFieldsContent.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -UIScreen.main.bounds.height * 0.2),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 154),
            imageView.widthAnchor.constraint(equalToConstant: 233),
                    
            stackFieldsContent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackFieldsContent.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 20),
            stackFieldsContent.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            stackFieldsContent.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21)
        ])
        
        setupFields()
        
//        textFieldTest.model = .init(placeholder: "Cpf", title: "Insira seu CPF", validator: { isValid in
//            print("valid")
//        })
    }
    
    private func setupFields() {
        let fields = section.masks.compactMap { mask -> FormFieldContent? in
            let formField = FormFieldContent(maskField: mask)
            formField.model = mask.formModel
            return formField
        }
        
        stackFieldsContent.add(fields)
    }
}
