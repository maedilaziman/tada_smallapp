//
//  Test_LoginModel.swift
//  TadaAppTests
//
//  Created by maedi laziman on 29/01/22.
//  Copyright © 2022 maedi laziman. All rights reserved.
//

import XCTest
@testable import TadaApp

class Test_LoginModel: XCTestCase {
    var model: LoginModel!
    
    override func setUpWithError() throws {
        print("setUpWithError")
        model = LoginModel(userName: "Medi", password: "pass123")
    }
    override func tearDownWithError() throws {
        model = nil
        print("tearDownWithError")
    }
    
    func test_ValidateUserName() {
        // Arrange - data should be provided to the test
        model.userName = "medi"
        
        // Act - Invoke the actual method under test
        let isValidUserName = model.isValidUserName
        
        // Assert
        XCTAssertTrue(isValidUserName, "User name is not a valid one")
    }
    
    func test_PasswordValidation() throws {
        // Arrange
        model.password = "pass1231"
        
        // Act
        let isValidPassword = model.isValidPassword
        
        // Assert
        XCTAssertTrue(isValidPassword, "Password is not a valid one")
    }
    
    func test_LoginModel_Nil() throws {
        XCTAssertNil(model,  "LoginModel is Not Nil")
        XCTAssertNotNil(model,  "LoginModel is Nil")
        
        
        if let theLoginModel = model {
            XCTAssertEqual(theLoginModel.userName.count, 0, "User Name is not Empty")
        } else {
            XCTFail("Failed to LoginModel")
        }
    }
    
    func test_LoginModel_ValidateUserNameCharacterLimit() {
        XCTAssertGreaterThan(CharacterRange.userNameMaxLength, model.userName.count, "UserName is GreaterThan \(CharacterRange.userNameMaxLength)")
        XCTAssertGreaterThanOrEqual(CharacterRange.userNameMaxLength, model.userName.count, "UserName is GreaterThanOrEqual to \(CharacterRange.userNameMaxLength)")
        
        XCTAssertLessThan(CharacterRange.userNameMinLength, model.userName.count, "UserName is LessThan \(CharacterRange.userNameMinLength)")
        XCTAssertLessThanOrEqual(CharacterRange.userNameMinLength, model.userName.count, "UserName is LessThanOrEqual to \(CharacterRange.userNameMinLength)")
    }
}
