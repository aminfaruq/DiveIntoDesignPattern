//
//  SingletonConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 18/07/24.
//

import XCTest
/// Singleton Design Pattern
///
/// Intent: Lets you ensure that a class has only one instance, while providing
/// a global access point to this instance.

import Foundation

/// The Singleton class defines the `shared` field that lets clients access the
/// unique singleton instance.
class Singleton {
    
    /// The static field that controls the access to the singleton instance.
    ///
    /// This implementation let you extend the Singleton class while keeping
    /// just one instance of each subclass around.
    static var shared: Singleton = {
        let instance = Singleton()
        // ... configure the instance
        // ...
        return instance
    }()
    
    /// The Singleton's initializer should always be private to prevent direct
    /// construction calls with the `new` operator.
    private init() {}
    
    /// Finally, any singleton should define some business logic, which can be
    /// executed on its instance.
    func someBusinessLogic() -> String {
        // ...
        "Result of the 'someBusinessLogic' call"
    }
}

/// Singletons should not be cloneable.
/*
extension Singleton: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
*/


private enum SingletonClient {
    // ...
    static func someClientCode() {
        let instance1 = Singleton.shared
        let instance2 = Singleton.shared

        if (instance1 === instance2) {
            print("Singleton works, both variables contain the same instance.")
        } else {
            print("Singleton failed, variables contain different instances.")
        }
    }
}

final class SingletonConceptualTests: XCTestCase {
    
    func test_singletonConceptual() {
        SingletonClient.someClientCode()
    }
}
