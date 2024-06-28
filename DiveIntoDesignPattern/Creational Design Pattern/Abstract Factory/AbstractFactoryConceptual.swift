//
//  AbstractFactoryConceptual.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 28/06/24.
//

import Foundation

//MARK: - STEP 1 -
/// Each distinct product of a product family should have a base protocol. All
/// variants of the product must implement this protocol.
protocol AbstractProductA {
    func usefulFunctionA() -> String
}

//MARK: - STEP 2a -

/// Concrete Products are created by corresponding Concrete Factories.
class ConcreteProductA1: AbstractProductA {
    func usefulFunctionA() -> String {
        return "The result of the product A1."
    }
}

class ConcreteProductA2: AbstractProductA {
    func usefulFunctionA() -> String {
        return "The result of the product A2."
    }
}

/// The base protocol of another product. All products can interact with each
/// other, but proper interaction is possible only between products of the same
/// concrete variant.
protocol AbstractProductB {

    /// Product B is able to do its own thing...
    func usefulFunctionB() -> String

    /// ...but it also can collaborate with the ProductA.
    ///
    /// The Abstract Factory makes sure that all products it creates are of the
    /// same variant and thus, compatible.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String
}

//MARK: - STEP 2b -

/// Concrete Products are created by corresponding Concrete Factories.
class ConcreteProductB1: AbstractProductB {

    func usefulFunctionB() -> String {
        return "The result of the product B1."
    }

    /// This variant, Product B1, is only able to work correctly with the
    /// variant, Product A1. Nevertheless, it accepts any instance of
    /// AbstractProductA as an argument.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B1 collaborating with the (\(result))"
    }
}

class ConcreteProductB2: AbstractProductB {

    func usefulFunctionB() -> String {
        return "The result of the product B2."
    }

    /// This variant, Product B2, is only able to work correctly with the
    /// variant, Product A2. Nevertheless, it accepts any instance of
    /// AbstractProductA as an argument.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B2 collaborating with the (\(result))"
    }
}

//MARK: - STEP 3 -
/// The Abstract Factory protocol declares a set of methods that return
/// different abstract products. These products are called a family and are
/// related by a high-level theme or concept. Products of one family are usually
/// able to collaborate among themselves. A family of products may have several
/// variants, but the products of one variant are incompatible with products of
/// another.
protocol AbstractFactory {
    func createProductA() -> AbstractProductA
    func createProductB() -> AbstractProductB
}

//MARK: - STEP 4a -
/// Concrete Factories produce a family of products that belong to a single
/// variant. The factory guarantees that resulting products are compatible. Note
/// that signatures of the Concrete Factory's methods return an abstract
/// product, while inside the method a concrete product is instantiated.
class ConcreteFactory1: AbstractFactory {
    func createProductA() -> AbstractProductA {
        return ConcreteProductA1()
    }
    
    func createProductB() -> AbstractProductB {
        return ConcreteProductB1()
    }
    
}
//MARK: - STEP 4b -
/// Each Concrete Factory has a corresponding product variant.
class ConcreteFactory2: AbstractFactory {

    func createProductA() -> AbstractProductA {
        return ConcreteProductA2()
    }

    func createProductB() -> AbstractProductB {
        return ConcreteProductB2()
    }
}
