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
