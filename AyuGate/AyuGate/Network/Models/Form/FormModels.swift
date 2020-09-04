//
//  FormModels.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 03/09/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

struct Form: ParsableProtocol {
    let id: String
    let sections: [Section]
    
    struct Section: Decodable {
        let id: String
        let title: String
        let description: String
        let imageSection: ImageSection?
        let fields: [Field]
    }
    
    struct ImageSection: Decodable {
        let url: String
        let orientation: String
    }
    
    struct Field: Decodable {
        let id: String
        let formIdentifier: String
        let title: String
        let placeholder: String
        let value: String
        let type: String
        let keyboardType: String
        let isSecurity: Bool
        let validate: String?
    }
}
