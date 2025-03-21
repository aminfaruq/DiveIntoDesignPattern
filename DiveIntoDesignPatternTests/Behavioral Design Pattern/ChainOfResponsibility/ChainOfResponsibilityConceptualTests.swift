//
//  ChainOfResponsibilityConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 21/03/25.
//

import XCTest

final class ChainOfResponsibilityConceptualTests: XCTestCase {
    
    func test_ChainResponsibility() {
        
        /// The other part of the client code constructs the actual chain.
        
        let monkey = MonkeyHandler()
        let squirrel = SquirrelHandler()
        let dog = DogHandler()
        monkey.setNext(handler: squirrel).setNext(handler: dog)
        
        /// The client should be able to send a request to any handler, not just
        /// the first one in the chain.
        
        print("Chain: Monkey > Squirrel > Dog\n\n")
        ChainOfResponsibilityClient.someClientCode(handler: monkey)
        print()
        print("Subchain: Squirrel > Dog\n\n")
        ChainOfResponsibilityClient.someClientCode(handler: squirrel)
    }
}
