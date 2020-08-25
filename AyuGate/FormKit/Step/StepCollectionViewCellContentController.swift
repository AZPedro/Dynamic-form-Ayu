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
    
    private lazy var scrollContentView: UIScrollView = {
        let scrollContentView = UIScrollView()
        scrollContentView.contentSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*2)
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        return scrollContentView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: section.sectionImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stackFieldsContent: UIStackView = {
        let stackView = UIStackView().vertical(20)

        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(scrollContentView)

        scrollContentView.addSubview(imageView)
        scrollContentView.addSubview(stackFieldsContent)
    
    
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            scrollContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 50),
            imageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 154),
            imageView.widthAnchor.constraint(equalToConstant: 233),
                    
            stackFieldsContent.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            stackFieldsContent.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            stackFieldsContent.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-44),
            stackFieldsContent.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor)
        ])
        
        setupFields()
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
