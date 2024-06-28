//
//  BuilderConceptual.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 28/06/24.
//

import Foundation

/// The Builder interface specifies methods for creating the different parts of
/// the Product objects.
protocol Builder {
    func producePartA()
    func producePartB()
    func producePartC()
}

/// The Concrete Builder classes follow the Builder interface and provide
/// specific implementations of the building steps. Your program may have
/// several variations of Builders, implemented differently.
class ConcreteBuilder1: Builder {
    /// A fresh builder instance should contain a blank product object, which is
    /// used in further assembly.
    private var product = Product1()
    
    func reset() {
        product = Product1()
    }
    
    /// All production steps work with the same product instance.
    func producePartA() {
        product.add(part: "PartA1")
    }
    
    func producePartB() {
        product.add(part: "PartB1")
    }
    
    func producePartC() {
        product.add(part: "PartC1")
    }
    
    /// Concrete Builders are supposed to provide their own methods for
    /// retrieving results. That's because various types of builders may create
    /// entirely different products that don't follow the same interface.
    /// Therefore, such methods cannot be declared in the base Builder interface
    /// (at least in a statically typed programming language).
    ///
    /// Usually, after returning the end result to the client, a builder
    /// instance is expected to be ready to start producing another product.
    /// That's why it's a usual practice to call the reset method at the end of
    /// the `getProduct` method body. However, this behavior is not mandatory,
    /// and you can make your builders wait for an explicit reset call from the
    /// client code before disposing of the previous result.
    func retrieveProduct() -> Product1 {
        let result = self.product
        reset()
        return result
    }
}

/// The Director is only responsible for executing the building steps in a
/// particular sequence. It is helpful when producing products according to a
/// specific order or configuration. Strictly speaking, the Director class is
/// optional, since the client can control builders directly.
class Director {

    private var builder: Builder?

    /// The Director works with any builder instance that the client code passes
    /// to it. This way, the client code may alter the final type of the newly
    /// assembled product.
    func update(builder: Builder) {
        self.builder = builder
    }

    /// The Director can construct several product variations using the same
    /// building steps.
    func buildMinimalViableProduct() {
        builder?.producePartA()
    }

    func buildFullFeaturedProduct() {
        builder?.producePartA()
        builder?.producePartB()
        builder?.producePartC()
    }
}

/// It makes sense to use the Builder pattern only when your products are quite
/// complex and require extensive configuration.
///
/// Unlike in other creational patterns, different concrete builders can produce
/// unrelated products. In other words, results of various builders may not
/// always follow the same interface.
class Product1 {
    private var parts = [String]()
    
    func add(part: String) {
        self.parts.append(part)
    }
    
    func listParts() -> String {
        return "Product parts: " + parts.joined(separator: ", ") + "\n"
    }
}