//
//  InvoiceDetailsViewModel.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 14/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

struct InvoicedetailsViewModel {
    let currentAmount: Double
    let companyName: String
    let customerRole: String
    let week: String
    let month: String
    let roll: [Invoice.PayRoll]
    
    var formattedCurrentAmount: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let formattedCurrency = formatter.string(from: NSNumber(value: currentAmount)) ?? "R$ 0,00"
        return formattedCurrency
    }
}
