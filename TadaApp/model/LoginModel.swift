//
//  LoginModel.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import Foundation

struct LoginModel {
    var userName = ""
    var password = ""
    
    init(userName: String, password: String) {
        self.userName = userName
        self.password = password
    }
    
    var isZeroUserName: Bool {
        if userName.count == 0 {
            return true
        }
        return false
    }
    
    var isValidUserName: Bool {
        if userName.count < CharacterRange.userNameMinLength ||
            userName.count > CharacterRange.userNameMaxLength {
            return false
        }
        return true
    }
    
    var isZeroPassword: Bool {
        if password.count == 0 {
            return true
        }
        return false
    }
    
    var isValidPassword: Bool {
        if password.count < CharacterRange.passwordMinLength ||
            password.count > CharacterRange.passwordMaxLength {
            return false
        }
        
        return true
    }
    
    var fullName: String? {
        return "\(userName)"
    }
}
