//
//  ViewController.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class DebugComponentsViewController: UIViewController {

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
        
        // logo label
        let logoLabel = AYULogoLabel()
        self.view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 20).isActive = true
        logoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //Invoice Details View
        let invoiceDetailsView = AYUInvoiceDetailsView()
        invoiceDetailsView.model = AYUInvoiceDetailsModel(value: 1800, type: .directDiscount, description: "Salário")
        
        self.view.addSubview(invoiceDetailsView)
        invoiceDetailsView.translatesAutoresizingMaskIntoConstraints = false
        invoiceDetailsView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 20).isActive = true
        invoiceDetailsView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        invoiceDetailsView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        invoiceDetailsView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        invoiceDetailsView.heightAnchor.constraint(equalToConstant: 37).isActive = true
        
        let pickerView = AYUMonthsPickerView()
        self.view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: invoiceDetailsView.bottomAnchor, constant: 20).isActive = true
        pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 37).isActive = true
        
    }
    
}

