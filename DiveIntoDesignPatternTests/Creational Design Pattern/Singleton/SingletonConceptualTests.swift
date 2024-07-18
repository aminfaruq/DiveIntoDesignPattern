//
//  SingletonConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 18/07/24.
//

import XCTest
import DiveIntoDesignPattern

private class Client {
    // ...
    static func someClientCode() {
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared

        if (instance1 === instance2) {
            print("Singleton works, both variables contain the same instance.")
        } else {
            print("Singleton failed, variables contain different instances.")
        }
    }
}

final class SingletonConceptualTests: XCTestCase {
    
    func test_singletonConceptual() {
        Client.someClientCode()
    }
}
