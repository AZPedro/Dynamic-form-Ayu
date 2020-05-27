//
//  AYURequest.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 11/05/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

class AYURequest: NSObject {
 
    struct Header {
        static let X_APP_ID = "f10500e1-aad8-4a2d-8483-bf85e9796dfd"
        static let X_APP_SECRETS = "815d41a4-0e25-4083-a9c7-399601f228aa"
    }
    
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private let url: URL
    private let method: RequestMethod
    private let body: [String: Any]?
    var request: URLRequest
    
    public init(route: AYURoute, _ method: RequestMethod = .get, body: [String: Any]?) {
        self.url = route.url
        self.request = URLRequest(url: url)
        self.method = method
        self.body = body
        
        super.init()
        
        setupRequest()
    }
    
    private func setupRequest() {
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = [
            "X-APP-ID": Header.X_APP_ID,
            "X-APP-SECRETS": Header.X_APP_SECRETS,
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        if let authToken = SessionManager.shared.authToken {
            request.addValue(authToken, forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
    }
}
    
