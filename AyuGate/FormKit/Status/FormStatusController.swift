//
//  FormStatusController.swift
//  FormKit
//
//  Created by Pedro Azevedo on 05/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import AyuKit

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
    
    public var actionButtonHandler: (() -> ())?
    var imageURL: String?
    
    private let actionButton: AYUActionButton = {
        let button = AYUActionButton()
        button.status = .enabled
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button.setTitle("Continuar")
    }()
    
    private lazy var statusHeader = FormStatusTitleMessageView(model: .init(size: .init(width: 58, height: 58), status: .header(imageURL), title: "Status de solicitação", message: "Aqui você pode acompanhar o andamento da sua solicitação para ser MEI"))
    private let step1 = FormStatusTitleMessageView(model: .init(size: .init(width: 40, height: 40), status: .valid, title: "Envio de informações", message: "Todos os dados enviados foram recebidos corretamente"))
    private let step2 = FormStatusTitleMessageView(model: .init(size: .init(width: 40, height: 40), status: .validating, title: "Validação", message: "Seus dados estão sendo validados e em breve você será notificado."))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    public init(imageURL: String?){
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        view.addSubview(mainsStack)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            mainsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            mainsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            mainsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -21),
            actionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
            actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -21)
        ])
    }
    
    @objc private func buttonAction() {
        actionButtonHandler?()
    }
}
