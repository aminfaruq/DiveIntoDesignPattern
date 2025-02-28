//
//  CompositeConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/02/25.
//

import XCTest

final class CompositeConceptualTests: XCTestCase {
    
    func test_CompositeConceptual() {
        
        /// This way client code can support the simple leaf components...
        print("Client: I've got a simple component:")
        CompositeClient.someClientCode(component: Leaf())
        
        /// ...as well ad the complex composites.
        let tree = Composite()
        
        let branch1 = Composite()
        branch1.add(component: Leaf())
        branch1.add(component: Leaf())
        
        let branch2 = Composite()
        branch2.add(component: Leaf())
        branch2.add(component: Leaf())
        
        tree.add(component: branch1)
        tree.add(component: branch2)
        
        print("\nClient: Now I've got a composite tree:")
        CompositeClient.someClientCode(component: tree)
        
        print("\nClient: I don't need to check the components classes even when managing the tree:")
        CompositeClient.moreComplexClientCode(leftComponent: tree, rightComponent: Leaf())
    }
}
