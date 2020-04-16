//
//  LogInManager.swift
//  ToDoListApp
//
//  Created by Cory Kim on 2020/04/14.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

class TokenManager {
    
    private let tokenKey = "JWTToken"
    private(set) var token: String? = nil
    
    func saveToken(_ token: String?) {
        if token == nil {
            UserDefaults.standard.removeObject(forKey: tokenKey)
        } else {
            UserDefaults.standard.set(token, forKey: tokenKey)
        }
    }
    
    func loadToken() {
        self.token = UserDefaults.standard.object(forKey: tokenKey) as? String
    }
}
