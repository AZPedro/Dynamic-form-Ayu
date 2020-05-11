//
//  NetworkManager.swift
//  AyuGate
//
//  Created by Pedro Azevedo on 24/04/20.
//  Copyright © 2020 AyuGate. All rights reserved.
//

import Foundation

protocol ParsableProtocol: Decodable {
    
}

struct Handler<T: ParsableProtocol>: Decodable {
    let response: T
}

class NetworkManager: NSObject {
    private let session: URLSession = URLSession.shared
    
    static var shared = NetworkManager()
    
    func makeRequest<T: ParsableProtocol>(request: AYURequest, completionHandler: @escaping ((Handler<T>) -> ())) {
        session.dataTask(with: request.request) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(Handler<T>.self, from: data)
                completionHandler(decoded)
            } catch let error {
                print(error)
            }
        }.resume()
        
    }
}

/*
 https://demo2715069.mockable.io/verify
 https://demo2715069.mockable.io/user/signup
 https://demo2715069.mockable.io/user/login
 https://demo2715069.mockable.io/auth/refresh_token
 */
