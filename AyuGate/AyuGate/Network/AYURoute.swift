//
//  AYURoute.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

class AYURoute {
    
    static let mockBaseURL: String = "http://46beb64e.ngrok.io"
    
    private let path: AyuPath
    
    init(path: AyuPath) {
        self.path = path
    }
    
    var url: URL {
        return URL(string: stringPath) ?? URL(fileURLWithPath: "")
    }
    
    private var stringPath: String {
        switch path {
        case .login:
            return "users/login"
        case .profile(let id):
            return "profile/\(id)"
        case .verify:
            return "users/verify"
        case .signUP:
            return "users"
        case .auth:
            return "auth"
        case .refresh:
            return "auth/refresh_token"
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
    }
    
    var resquest: AYURequest {
        return AYURequest(route: self, method, body: boody)
    }
}