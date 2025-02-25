//
//  AdapterConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 25/02/25.
//

import XCTest
@testable import DiveIntoDesignPattern

final class AdapterConceptualTests: XCTestCase {

    func test_AdapterConceptual() {
        print("Client: I can work just fine with the Target objects:")
        Client.someClientCode(target: Target())
        
        let adaptee = Adaptee()
        print("Client: The Adaptee class has a weird interface. See, I don't understand it:")
        print("Adaptee: " + adaptee.specificRequest())
        
        print("Client: But I can work with it via the Adapter:")
        Client.someClientCode(target: Adapter(adaptee))
    }

}
