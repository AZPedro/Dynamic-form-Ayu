//
//  Profile.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 13/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

struct AccountInfo {
    let name: String
    let cpf: String
    let avatarURL: String
    let pis: String
    let role: String
    
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
}
