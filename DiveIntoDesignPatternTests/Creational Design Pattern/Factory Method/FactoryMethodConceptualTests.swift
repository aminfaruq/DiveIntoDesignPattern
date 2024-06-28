//
//  FactoryMethodConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/06/24.
//

import XCTest
import DiveIntoDesignPattern

final class FactoryMethodConceptualTests: XCTestCase {
    
    func test_FactoryMethodConceptual() {
        /// The Application picks a creator's type depending on the
        /// configuration or environment
        print("App: Launched with the ConcreteCreator1.")
        Client.someClientCode(creator: ConcreteCreator1())
        
        print("\nApp: Launched with the ConcreteCreator2.")
        Client.someClientCode(creator: ConcreteCreator2())
    }
}
