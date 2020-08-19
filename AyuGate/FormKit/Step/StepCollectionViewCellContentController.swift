//
//  StepCollectionViewCellContentController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 12/08/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class StepCollectionViewCellContentController: UIViewController {
    
    private var maskField: MaskField
    
    private lazy var textFieldTest: FormFieldContent = {
        return FormFieldContent(maskField: maskField)
    }()
    
    init(maskField: MaskField) {
        self.maskField = maskField
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
        view.addSubview(textFieldTest)
    
        textFieldTest.translatesAutoresizingMaskIntoConstraints = false
        textFieldTest.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textFieldTest.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textFieldTest.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21).isActive = true
        textFieldTest.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21).isActive = true
        
        textFieldTest.model = .init(placeholder: "Cpf", title: "Insira seu CPF", validator: { isValid in
            print("valid")
        })
    }
}
