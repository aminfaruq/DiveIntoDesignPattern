//
//  FactoryMethodConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/06/24.
//

import XCTest
/// Factory Method Design Pattern
///
/// Intent: Provides an interface for creating objects in a superclass, but
/// allows subclasses to alter the type of objects that will be created.
import Foundation

//MARK: - STEP 1 -
/// The Product protocol declares the operations that all concrete products must
/// implement.
protocol Product {
    func operation() -> String
}

//MARK: - STEP 2 -
/// Concrete Products provide various implementations of the Product protocol.
class ConcreteProduct1: Product {
    func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}

class ConcreteProduct2: Product {
    func operation() -> String {
        return "{Result of the ConcreteProduct2}"
    }
}

//MARK: - STEP 3 -
/// The Creator protocol declares the factory method that's supposed to return a
/// new object of a Product class. The Creator's subclasses usually provide the
/// implementation of this method.
protocol Creator {

    /// Note that the Creator may also provide some default implementation of
    /// the factory method.
    func factoryMethod() -> Product

    /// Also note that, despite its name, the Creator's primary responsibility
    /// is not creating products. Usually, it contains some core business logic
    /// that relies on Product objects, returned by the factory method.
    /// Subclasses can indirectly change that business logic by overriding the
    /// factory method and returning a different type of product from it.
    func someOperation() -> String
}

/// This extension implements the default behavior of the Creator. This behavior
/// can be overridden in subclasses.
extension Creator {
    
    func someOperation() -> String {
        //Call the factory method to create a Product object.
        let product = factoryMethod()
        
        return "Creator: The same creator's code has just worked with " + product.operation()
    }
    
}

//MARK: - STEP 4 -
/// Concrete Creators override the factory method in order to change the
/// resulting product's type.
class ConcreteCreator1: Creator {
    
    /// Note that the signature of the method still uses the abstract product
    /// type, even though the concrete product is actually returned from the
    /// method. This way the Creator can stay independent of concrete product
    /// classes.
    func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    
    /// Note that the signature of the method still uses the abstract product
    /// type, even though the concrete product is actually returned from the
    /// method. This way the Creator can stay independent of concrete product
    /// classes.
    func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}


/// The client code works with an instance of a concrete creator, albeit through
/// its base protocol. As long as the client keeps working with the creator via
/// the base protocol, you can pass it any creator's subclass.
private enum FactoryClient {
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
        FactoryClient.someClientCode(creator: ConcreteCreator1())
        
        print("\nApp: Launched with the ConcreteCreator2.")
        FactoryClient.someClientCode(creator: ConcreteCreator2())
    }
}
