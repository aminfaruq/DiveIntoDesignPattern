//
//  PrototypeConcentualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 30/06/24.
//

import XCTest

private enum Client {
    // ...
    static func someClientCode() {
        let original = SubClass(intValue: 2, stringValue: "Value2")
        
        guard let copy = original.copy() as? SubClass else {
            XCTAssert(false)
            return
        }
        
        ///See implementation of `Equatable` protocol for more details.
        XCTAssert(copy == original)
        
        print("The original object is equal to the copied object!")
    }
    // ...
}

final class PrototypeConcentualTests: XCTestCase {
    
    func test_Prototype_NSCopying() {
        Client.someClientCode()
    }
    
}
