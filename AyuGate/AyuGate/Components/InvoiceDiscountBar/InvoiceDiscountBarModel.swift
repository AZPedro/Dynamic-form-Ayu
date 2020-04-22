//
//  InvoiceDiscountBarModel.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

struct InvoiceDiscountBarViewModel {
    
    let model: InvoiceDiscountBarModel
    
    private var total: Double {
        return model.discount + model.input + model.netValue
    }
    
    var inputPercent: Double {
        return model.input / total * 100
    }
    
    var neValuePercent: Double {
        return model.netValue / total * 100
    }
    
    var discountPercent: Double {
        return model.netValue * total / 100
    }
}

struct InvoiceDiscountBarModel {
    let discount: Double
    let input: Double
    let netValue: Double
}
