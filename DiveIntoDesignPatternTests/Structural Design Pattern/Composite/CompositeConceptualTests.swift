//
//  CompositeConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/02/25.
//

import XCTest

/// Composite Design Pattern
///
/// Intent: Lets you compose objects into tree structures and then work with
/// these structures as if they were individual objects.

/// The base Component class declares common operations for both simple and
/// complex objects of a composition.
protocol CompositeComponent {
    /// The base Component may optionally declare methods for setting and
    /// accessing a parent of the component in a tree structure. It can also
    /// provide some default implementation for these methods.
    var parent: CompositeComponent? { get set }
    
    /// In some cases, it would be beneficial to define the child-management
    /// operations right in the base Component class. This way, you won't need
    /// to expose any concrete component classes to the client code, even during
    /// the object tree assembly. The downside is that these methods will be
    /// empty for the leaf-level components.
    func add(component: CompositeComponent)
    
    /// You can provide a method that lets the client code figure out whether a
    /// component can bear children.
    func isComposite() -> Bool
    
    /// The base Component may implement some default behavior or leave it to
    /// concrete classes.
    func operation() -> String
}

extension CompositeComponent {
    
    func add(component: CompositeComponent) {}
    
    func remove(component: CompositeComponent) {}
    
    func isComposite() -> Bool { false }
}

/// The Leaf class represents the end objects of a composition. A leaf can't
/// have any children.
///
/// Usually, it's the Leaf objects that do the actual work, whereas Composite
/// objects only delegate to their sub-components.
class Leaf: CompositeComponent {
    var parent: CompositeComponent?
    
    func operation() -> String {
        "Leaf"
    }
}

/// The Composite class represents the complex components that may have
/// children. Usually, the Composite objects delegate the actual work to their
/// children and then "sum-up" the result.
class Composite: CompositeComponent {
    var parent: CompositeComponent?
    
    /// This fields contains the component subtree.
    private var children = [CompositeComponent]()
    
    /// A composite object can add or remove other components (both simple or complex) to or from its child list.
    func add(component: CompositeComponent) {
        var item = component
        item.parent = self
        children.append(item)
    }
    
    func remove(component: CompositeComponent) {
        // ...
    }
    
    func isComposite() -> Bool {
        true
    }
    
    /// The Composite executes its primary logic in a particular way. It
    /// traverses recursively through all its children, collecting and summing
    /// their results. Since the composite's children pass these calls to their
    /// children and so forth, the whole object tree is traversed as a result.
    func operation() -> String {
        let result = children.map({ $0.operation() })
        return "Branch(\(result.joined(separator: " ")))"
    }
}

class CompositeClient {
    
    /// The client  code works with all of the components via the base inteface.
    static func someClientCode(component: CompositeComponent) {
        print("Result: \(component.operation())")
    }
    
    /// Thanks to the fact that the child-management operations are also
    /// declared in the base Component class, the client code can work with both
    /// simple or complex components.
    static func moreComplexClientCode(leftComponent: CompositeComponent, rightComponent: CompositeComponent) {
        if leftComponent.isComposite() {
            leftComponent.add(component: rightComponent)
        }
        
        print("Result: " + leftComponent.operation())
    }
}


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
