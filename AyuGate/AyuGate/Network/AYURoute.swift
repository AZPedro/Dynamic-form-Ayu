//
//  AYURoute.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

class AYURoute {
    
    private let mockBaseURL: String = "http://ec2-54-211-42-129.compute-1.amazonaws.com/"
    
    private let path: AyuPath
    
    init(path: AyuPath) {
        self.path = path
    }
    
    var url: URL {
        return URL(string: "\(mockBaseURL)\(stringPath)") ?? URL(fileURLWithPath: "")
    }
    
    private var stringPath: String {
        switch path {
        case .login:
            return "users/login"
        case .profile:
            return "profile/me"
        case .verify:
            return "users/verify"
        case .signUP:
            return "users"
        case .auth:
            return "auth"
        case .refresh:
            return "auth/refresh_token"
        case .payRoll(let month):
            return "payroll?month=\(month)"
        case .currentPayrol:
            return "payroll/current"
        }
    }
    
    private var boody: [String: Any]? {
        switch path {
        case .login(let cpf, let password):
            return ["cpf": cpf, "password": password]
        case .verify(let cpf):
            return ["cpf": cpf]
        case .signUP(let cpf, let password):
            return ["cpf": cpf, "password": password, "confirmPassword": password]
        case .refresh(let refreshToken):
            return ["refreshToken": refreshToken]
        default:
            return nil
        }
    }
    
    private var method: AYURequest.RequestMethod {
        switch path {
        case .profile:
            return .get
        case .payRoll:
            return .get
        case .currentPayrol:
            return .get
        default:
            return .post
        }
    }
}

extension AYURoute {
    enum AyuPath {
        case login(cpf: String, password: String)
        case profile(id: String)
        case verify(cpf: String)
        case signUP(cpf: String, password: String)
        case auth
        case refresh(refreshToken: String)
        case payRoll(month: String)
        case currentPayrol
    }
    
    public var resquest: AYURequest {
        return AYURequest(route: self, method, body: boody)
    }
}
