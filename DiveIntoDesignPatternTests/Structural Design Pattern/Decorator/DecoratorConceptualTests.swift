//
//  DecoratorConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Phincon on 04/03/25.
//

import XCTest

/// The base Component interface defines operations that can be altered by
/// decorators.
protocol DecoratorComponent {
    
    func operation() -> String
}

/// Concrete Components provide default implementations of the operations. There
/// might be several variations of these classes.
class ConcreteComponent: DecoratorComponent {
    
    func operation() -> String {
        return "ConcreteComponent"
    }
}

/// The base Decorator class follows the same interface as the other components.
/// The primary purpose of this class is to define the wrapping interface for
/// all concrete decorators. The default implementation of the wrapping code
/// might include a field for storing a wrapped component and the means to
/// initialize it.
class Decorator: DecoratorComponent {
    
    private var component: DecoratorComponent
    
    init(_ component: DecoratorComponent) {
        self.component = component
    }
    
    func operation() -> String {
        component.operation()
    }
}

/// Concrete Decorators call the wrapped object and alter its result in some
/// way.
class ConcreteDecoratorA: Decorator {
    
    /// Decorators may call parent implementation of the operation, instead of
    /// calling the wrapped object directly. This approach simplifies extension
    /// of decorator classes.
    override func operation() -> String {
        "ConcreteDecoratorA(" + super.operation() + ")"
    }
}

/// Decorators can execute their behavior either before or after the call to a
/// wrapped object.
class ConcreteDecoratorB: Decorator {
    
    override func operation() -> String {
        "ConcreteDecoratorB(" + super.operation() + ")"
    }
}

/// The client code works with all objects using the Component interface. This
/// way it can stay independent of the concrete classes of components it works
/// with.
class DecoratorClient {
    // ...
    static func someClientCode(component: DecoratorComponent) {
        print("Result: " + component.operation())
    }
    // ...
}

final class DecoratorConceptualTests: XCTestCase {

    func test_DecoratorConceptua() {
        // This way the client code can support both simple components...
        print("Client: I've got a simple component")
        let simple = ConcreteComponent()
        DecoratorClient.someClientCode(component: simple)
        
        // ...as well as decorated ones.
        //
        // Note how decorators can wrap not only simple components but the other
        // decorators as well.
        let decorator1 = ConcreteDecoratorA(simple)
        let decorator2 = ConcreteDecoratorB(decorator1)
        print("\nClient: Now I've got a decorated component")
        DecoratorClient.someClientCode(component: decorator2)
    }
}
