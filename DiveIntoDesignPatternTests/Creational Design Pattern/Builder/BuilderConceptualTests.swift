//
//  BuilderConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/06/24.
//

import XCTest
import DiveIntoDesignPattern

/// The client code creates a builder object, passes it to the director and then
/// initiates the construction process. The end result is retrieved from the
/// builder object.
private enum Client {
    // ...
    static func someClientCode(director: Director) {
        let builder = ConcreteBuilder1()
        director.update(builder: builder)
        
        print("Standard basic product:")
        director.buildMinimalViableProduct()
        print(builder.retrieveProduct().listParts())

        print("Standard full featured product:")
        director.buildFullFeaturedProduct()
        print(builder.retrieveProduct().listParts())

        // Remember, the Builder pattern can be used without a Director class.
        print("Custom product:")
        builder.producePartA()
        builder.producePartC()
        print(builder.retrieveProduct().listParts())
    }
    // ...
}


final class BuilderConceptualTests: XCTestCase {
    
    func test_BuilderConceptual() {
        let director = Director()
        Client.someClientCode(director: director)
    }
}
