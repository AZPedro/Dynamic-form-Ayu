//
//  ViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // spineer
        let spinner = AYUSpinnerView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spinner)

        spinner.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        spinner.state = .spinning

        //textfield
        let textField = AYUTextField()
        self.view.addSubview(textField)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 20).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 11).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textField.updateState(state: .notInputed)
        
        // action button
        let actionButton = AYUButton(title: "Continuar", titleColor: .yellowPrimary)
        self.view.addSubview(actionButton)
        
        actionButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        actionButton.handler = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                textField.updateState(state: .failed)
                actionButton.updateState(state: .error)
            }
        }
        // logo label
        let logoLabel = AYULogoLabel()
        self.view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 20).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        // barview
        let barView = AYUInvoiceDiscountBar(model: InvoiceDiscountBarViewModel(model: InvoiceDiscountBarModel(discount: 130, input: 1000, netValue: 870)))
        
        self.view.addSubview(barView)
        barView.translatesAutoresizingMaskIntoConstraints = false
        barView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20).isActive = true
        barView.heightAnchor.constraint(equalToConstant: 219).isActive = true
        barView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            barView.animate()
        }
    }
    
}

