//
//  CpfRegisterViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 16/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit
import FormKit
import AyuKit

class CpfRegisterViewController: AYUViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    var delegate: CpfRegisterFlowDelegate?
    
    private let networkManager = NetworkManager.shared
    
    lazy var cpfFormView: FormFieldContent = {
        let view = FormFieldContent(maskField: maskDependence.first!)
        return view
    }()
    
    lazy var stepBottomSegmentController: StepBottomSegmentController = {
        let stepBottomSegmentController = StepBottomSegmentController(delegate: self)
        stepBottomSegmentController.isValid = false
        stepBottomSegmentController.hasBackOption = false
        return stepBottomSegmentController
    }()
    
    var maskDependence: [MaskField]
    
    init(maskDependence: [MaskField]) {
        self.maskDependence = maskDependence
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        view.backgroundColor = .white
        
        setupCPFFormView()
        installBottonSegment()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
    }
    
    private func installBottonSegment() {
        addChild(stepBottomSegmentController)
        view.addSubview(stepBottomSegmentController.view)
        stepBottomSegmentController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            stepBottomSegmentController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stepBottomSegmentController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stepBottomSegmentController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCPFFormView() {
        view.addSubview(cpfFormView)
        cpfFormView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        cpfFormView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cpfFormView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        cpfFormView.model = FormFieldContent.Model(placeholder: "CPF", title: "Insira seu CPF", validator: { isValidCPFText in
            self.stepBottomSegmentController.isValid = isValidCPFText
        })
    }
    
    private func verifyCPF(text: String?) {
        guard let cpfValue = text else { return }

        let request = AYURoute(path: .verify(cpf: cpfValue)).resquest

        networkManager.makeRequest(request: request) { (result: Handler<Verify>?, error) in
            guard let result = result?.response else {
                return
            }

            let model = CPFVerifyViewModel(model: result, cpf: cpfValue)
            self.delegate?.cpfRegisterControllerDelegateVerify(didFinished: model, controller: self)
        }
    }
    
    @objc func dismissKeyboard() {
//        self.cpfFormView.textField.resignFirstResponder()
    }
}

extension CpfRegisterViewController: StepBottomSegmentControllerDelegate{
    func stepBottomSegmentControllerDelegate(didNext: StepBottomSegmentController) {
        verifyCPF(text: cpfFormView.value)
    }
    
    func stepBottomSegmentControllerDelegate(didBack: StepBottomSegmentController) {
        
    }
}

