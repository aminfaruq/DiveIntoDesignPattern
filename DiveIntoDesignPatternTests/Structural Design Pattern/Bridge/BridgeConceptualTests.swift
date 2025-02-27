//
//  BridgeConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 27/02/25.
//

import XCTest
import DiveIntoDesignPattern

final class BridgeConceptualTests: XCTestCase {
    
    func test_BridgeConceptual() {
        // The client code should be able to work with any pre-configured
        // abstraction-implementation combination.
        let implementation = ConcreteImplementationA()
        BridgeClient.someClientCode(abstraction: Abstraction(implementation))
        
        let concreteImplementation = ConcreteImplementationB()
        BridgeClient.someClientCode(abstraction: ExtendedAbstraction(concreteImplementation))
    }
}
