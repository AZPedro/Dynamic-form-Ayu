//
//  InvoiceDetailsViewModel.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

class InvoicedetailsViewModel {
    let currentAmount: Double
    let customerName: String
    let companyName: String
    let customerRole: String
    let cpfValue: String
    let roll: [Invoice.PayRoll]
    
    var formattedCurrentAmount: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let formattedCurrency = formatter.string(from: NSNumber(value: currentAmount)) ?? "R$ 0,00"
        return formattedCurrency
    }
    
    init(invoice: Invoice, profile: AccountInfo) {
        currentAmount = invoice.payroll.first?.amount ?? 0
        cpfValue = profile.cpf
        customerName = profile.name
        companyName = invoice.company.name
        roll = invoice.payroll
        customerRole =  invoice.role.name
    }
}
