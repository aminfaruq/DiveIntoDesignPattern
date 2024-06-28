//
//  FactoryMethodConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/06/24.
//

import XCTest
import DiveIntoDesignPattern

/// The client code works with an instance of a concrete creator, albeit through
/// its base protocol. As long as the client keeps working with the creator via
/// the base protocol, you can pass it any creator's subclass.
private enum Client {
    static func someClientCode(creator: Creator) {
        print("Client: I'm not aware of the creator's class, but it still works.\n"
            + creator.someOperation())
    }
}

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
