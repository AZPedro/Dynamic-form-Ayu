//
//  CPFRegisterViewModel.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 24/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

class CPFVerifyViewModel {
    public let model: Verify
    public let cpf: String
    
    enum Status: String {
        case newUser = "newUser"
        case alreadyExists = "alreadyExists"
        case notFound = "notFound"
    }
    
    var status: Status {
        return Status(rawValue: model.status) ?? .notFound
    }
    
    var formattedCPF: String {
        let ranges = [3,6]
        let _range = 9
        
        var cpf: String = ""
        
        self.cpf.enumerated().forEach { (index, element) in
            if ranges.contains(index) {
                cpf.append(".")
                cpf.append(element)
            } else if index == _range {
                cpf.append("-")
                cpf.append(element)
            } else {
                cpf.append(element)
            }
        }
        
        return cpf
    }
    
    
    init(model: Verify, cpf: String) {
        self.model = model
        self.cpf = cpf
    }
}
