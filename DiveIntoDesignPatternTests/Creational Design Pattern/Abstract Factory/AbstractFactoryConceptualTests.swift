//
//  AbstractFactoryConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/06/24.
//

import XCTest
import DiveIntoDesignPattern

//MARK: - STEP 5 -
/// The client code works with factories and products only through abstract
/// types: AbstractFactory and AbstractProduct. This lets you pass any factory
/// or product subclass to the client code without breaking it.
private enum Client {
    // ...
    static func someClientCode(factory: AbstractFactory) {
        let productA = factory.createProductA()
        let productB = factory.createProductB()

        print(productB.usefulFunctionB())
        print(productB.anotherUsefulFunctionB(collaborator: productA))
    }
    // ...
}

final class AbstractFactoryConceptualTests: XCTestCase {
    func test_AbstractFactoryConceptual() {
        /// The client code can work with any concrete factory class.
        print("Client: Testing client code with the first factory type")
        Client.someClientCode(factory: ConcreteFactory1())
        
        print("Client: Testing the same client code with the second factory type:")
        Client.someClientCode(factory: ConcreteFactory2())
    }
}
