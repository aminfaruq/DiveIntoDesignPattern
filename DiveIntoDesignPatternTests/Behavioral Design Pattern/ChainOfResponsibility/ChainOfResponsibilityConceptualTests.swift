//
//  ChainOfResponsibilityConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 21/03/25.
//

import XCTest

/// Chain of Responsibility Design Pattern
///
/// Intent: Lets you pass requests along a chain of handlers. Upon receiving a
/// request, each handler decides either to process the request or to pass it to
/// the next handler in the chain.

import Foundation

/// The Handler interface declares a method for building the chain of handlers.
/// It also declares a method for executing a request.
protocol Handler: AnyObject {
    
    @discardableResult
    func setNext(handler: Handler) -> Handler
    
    func handle(request: String) -> String?
    
    var nextHandler: Handler? { get set }
}

extension Handler {
    
    func setNext(handler: Handler) -> Handler {
        self.nextHandler = handler
        /// Returning a handler from here will let us link handlers in a
        /// convinient way like this:
        /// monkey.setNext(handler: squirrel).setNext(handler: dog)
        
        return handler
    }
    
    func handler(request: String) -> String? {
        return nextHandler?.handle(request: request)
    }
}

/// All Concrete Handlers either handle a request or pass it ti the next handler
/// in the chain.
class MonkeyHandler: Handler {
    
    var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        if request == "Banana" {
            "Monkey: I'LL eat the " + request + ".\n"
        } else {
            nextHandler?.handle(request: request)
        }
    }
}

class SquirrelHandler: Handler {
    
    var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        if request == "Nut" {
            "Squirrel: I'LL eat the " + request + ".\n"
        } else {
            nextHandler?.handle(request: request)
        }
    }
}

class DogHandler: Handler {
    
    var nextHandler: Handler?
    
    func handle(request: String) -> String? {
        if request == "MeatBall" {
            "Dog: I'll eat the " + request + ".\n"
        } else {
            nextHandler?.handle(request: request)
        }
    }
}

/// The client is usually suited to work with a single handler. In most
/// cases. it is not even aware that the handler is part of a chain.
class ChainOfResponsibilityClient {
    // ...
    static func someClientCode(handler: Handler) {
        
        let food = ["Nut", "Banana", "Cup of coffe"]
        
        for item in food {
            
            print("Client: Who wants a " + item + "?\n")
            
            guard let result = handler.handle(request: item) else {
                print(" " + item + " was left untouched.\n ")
                return
            }
            
            print(" \(result)")
        }
    }
    // ...
}


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
