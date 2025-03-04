//
//  DecoratorConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Phincon on 04/03/25.
//

import XCTest

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
