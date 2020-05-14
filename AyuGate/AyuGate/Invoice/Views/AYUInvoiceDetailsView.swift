//
//  AYUInvoiceDetailsView.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 04/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import UIKit

class AYUInvoiceDetailsView: AYUDetailInfoView {
    
    var model: AYUInvoiceDetailsViewModel? {
        didSet {
            updateUI()
        }
    }
    
    override func updateUI() {
        guard let model = model else { return }
        
        switch model.type {
        case .fixedDiscounts:
            verticalBarIndicator.backgroundColor = UIColor.redSecondary
            valueLabel.textColor = UIColor.redSecondary
            
        case .discount:
            verticalBarIndicator.backgroundColor = UIColor.yellowTerciary
            valueLabel.textColor = UIColor.yellowTerciary
        case .liquid:
            verticalBarIndicator.backgroundColor = UIColor.greenPrimary
            valueLabel.textColor = UIColor.greenPrimary
        }
        
        titleLabel.text = model.description
        valueLabel.text = model.formattedValue
    }
}

struct AYUInvoiceDetailsViewModel {
    let value: Double
    let type: Invoice.PayRoll.DiscountType
    let description: String
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let formattedCurrency = formatter.string(from: NSNumber(value: value)) ?? "R$ 0,00"
        if type == .fixedDiscounts {
            return "-\(formattedCurrency)"
        }
        return formattedCurrency
    }
    
    init(roll: Invoice.PayRoll) {
        value = roll.amount
        type = roll.discountType
        description = roll.description
    }
    
}
