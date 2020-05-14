//
//  InvoiceDiscountBarModel.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 15/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

struct InvoiceDiscountBarViewModel {

    let model: [InvoiceDiscountBarModel]?
    
    var liquidPercent: Double {
        return model?.filter({ $0.discountType == InvoiceDiscountBarModel.DiscountType.liquid  }).first?.percentage ?? 0 * 10
    }
    
    var discountPercent: Double {
        return model?.filter({ $0.discountType == InvoiceDiscountBarModel.DiscountType.discount  }).first?.percentage ?? 0 * 10
    }
    
    var fixedDiscountPercent: Double {
        return model?.filter({ $0.discountType == InvoiceDiscountBarModel.DiscountType.fixedDiscounts  }).first?.percentage ?? 0 * 10
    }

}

struct InvoiceDiscountBarModel {
    let type: String
    let percentage: Double
    
    var discountType: DiscountType? {
        return DiscountType(rawValue: type)
    }
    
    enum DiscountType: String {
        case discount = "discount"
        case fixedDiscounts = "fixedDiscounts"
        case liquid = "liquid"
    }

}
