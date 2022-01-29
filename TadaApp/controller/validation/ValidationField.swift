//
//  ValidationField.swift
//  TadaApp
//
//  Created by maedi laziman on 30/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import Foundation
import UIKit

class ValidationField {
    
    var loginModel: LoginModel?
    
    var registerModel: RegisterModel?
    
    init(loginModel: LoginModel? = nil, registerModel: RegisterModel? = nil) {
        self.loginModel = loginModel
        self.registerModel = registerModel
    }
    
    func validationAllLoginField(ctr: UIViewController) -> Bool {
        var message = ""
        var valid = true
        if loginModel!.isZeroUserName {
            message = "Username should not be empty"
            valid = false
        }
        else if loginModel!.isZeroPassword {
            message = "Password should not be empty"
            valid = false
        }
        else if !loginModel!.isValidUserName {
            message = "Username should not less than 3 and should not greater than 10 char"
            valid = false
        }
        else if !loginModel!.isValidPassword {
            message = "Password should not less than 6 and should not greater than 16 char"
            valid = false
        }
        if !valid {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            ctr.present(alert, animated: true, completion: nil)
        }
        
        return valid
    }
    
    func validationAllRegisterField(ctr: UIViewController) -> Bool {
        var message = ""
        var valid = true
        if registerModel!.isZeroUserName {
            message = "Username should not be empty"
            valid = false
        }
        else if registerModel!.isZeroPassword {
            message = "Password should not be empty"
            valid = false
        }
        else if !registerModel!.isValidUserName {
            message = "Username should not less than 3 and should not greater than 10 char"
            valid = false
        }
        else if !registerModel!.isValidPassword {
            message = "Password should not less than 6 and should not greater than 16 char"
            valid = false
        }
        else if !registerModel!.checkTermCondition {
            message = "You should check mark Terms and Condition"
            valid = false
        }
        if !valid {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            ctr.present(alert, animated: true, completion: nil)
        }
        
        return valid
    }
}
