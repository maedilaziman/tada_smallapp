//
//  RegisterModel.swift
//  TadaApp
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import Foundation

struct RegisterModel {
    var userName = ""
    var password = ""
    var checkTermCondition = false
    
    init(userName: String, password: String, checkTermCondition: Bool) {
        self.userName = userName
        self.password = password
        self.checkTermCondition = checkTermCondition
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
    
    var isCheckTermCondition: Bool {
        return checkTermCondition
    }
    
    var fullName: String? {
        return "\(userName)"
    }
}
