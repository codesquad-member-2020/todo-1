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
    
    func saveToken(_ token: String?) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func loadToken() -> String? {
        let token = UserDefaults.standard.object(forKey: tokenKey) as? String
        return token
    }
}
