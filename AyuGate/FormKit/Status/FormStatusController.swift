//
//  FormStatusController.swift
//  FormKit
//
//  Created by Pedro Azevedo on 05/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class StatusFormController: UIViewController {
    
    private lazy var mainsStack: UIStackView = {
        let stack = UIStackView().vertical()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.add([
            statusHeader,
            step1,
            step2
        ])
        
        stack.setCustomSpacing(-3, after: statusHeader)
        stack.setCustomSpacing(-3, after: step1)
        
        return stack
    }()
    
    private let statusHeader = FormStatusTitleMessageView(model: .init(size: .init(width: 58, height: 58), status: .header(UIImage(named: "MockedIconProfile")), title: "MEI Status", message: "Aqui você pode acompanhar o andamento da sua solicitação para ser MEI"))
    private let step1 = FormStatusTitleMessageView(model: .init(size: .init(width: 40, height: 40), status: .valid, title: "Validação", message: "Aqui você pode acompanhar o andamento Da sua solicitação para ser MEI"))
    private let step2 = FormStatusTitleMessageView(model: .init(size: .init(width: 40, height: 40), status: .validating, title: "Validação", message: "Aqui você pode acompanhar o andamento Da sua solicitação para ser MEI"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        view.addSubview(mainsStack)
        
        NSLayoutConstraint.activate([
            mainsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            mainsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            mainsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26)
        ])
    }
}
