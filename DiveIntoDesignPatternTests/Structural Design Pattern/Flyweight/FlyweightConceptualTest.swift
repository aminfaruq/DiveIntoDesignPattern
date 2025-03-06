//
//  FlyweightConceptualTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 06/03/25.
//

import XCTest

final class FlyweightConceptualTest: XCTestCase {
    
    func test_Flyweight() {
        /// The client code usually creates a bunch of pre-populated flyweights
        /// in the initialization stage of the application.
        let factory = FlyweightFactory(states:
        [
            ["Chevrolet", "Camaro2018", "pink"],
            ["Mercedes Benz", "C300", "black"],
            ["Mercedes Benz", "C500", "red"],
            ["BMW", "M5", "red"],
            ["BMW", "X6", "white"]
        ])

        factory.printFlyweights()
        
        /// ...
        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "M5",
                "red")
        
        addCarToPoliceDatabase(factory,
                "CL234IR",
                "James Doe",
                "BMW",
                "X1",
                "red")
        
        factory.printFlyweights()
    }
    
    func addCarToPoliceDatabase(
        _ factory: FlyweightFactory,
        _ plates: String,
        _ owner: String,
        _ brand: String,
        _ model: String,
        _ color: String
    ) {
        print("Client: Adding a car to database.\n")
        
        let flyweight = factory.flyweight(for: [brand, model, color])
        
        /// The client code either stores or calculates extrinsic state and
        /// passes it to the flyweight's methods.
        flyweight.operation(uniqueState: [plates, owner])
    }
}
