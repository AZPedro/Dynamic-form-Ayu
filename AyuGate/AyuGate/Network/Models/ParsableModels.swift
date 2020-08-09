//
//  ParsableModels.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 24/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

struct Verify: ParsableProtocol {
    let status: String
}

struct Login: ParsableProtocol {
    let accessToken: String
    let refreshToken: String
}

struct Validation: Decodable {
    let status: Int
    let code: String
    let message: String
    
    static var genericError = Validation(status: 0, code: "", message: "")
}

struct Invoice: ParsableProtocol {
    let id: String
    let liquidAmount: Double
    let month: String
    let percentage: [Percentage]
    let company: Role
    let role: Role
    let payroll: [PayRoll]
    
    struct Percentage: Decodable {
        let type: String
        let percentage: Double
    }
    
    struct Role: Decodable {
        let id: String
        let name: String
    }

    struct PayRoll: Decodable {
        let type: String
        let description: String
        let amount: Double
        
        var discountType: DiscountType {
            return DiscountType(rawValue: type) ??  DiscountType.liquid
        }
           
        enum DiscountType: String {
           case discount = "discount"
           case fixedDiscounts = "fixedDiscounts"
           case liquid = "liquid"
        }
    }
}

struct ProfileParsable: ParsableProtocol {
    let id: String
    let cpf: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cpf = "cpf"
        case name = "name"
    }
}
