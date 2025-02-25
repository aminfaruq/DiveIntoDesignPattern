//
//  AdapterConceptual.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 25/02/25.
//

/// The Target defines the domain-specific interface used by the client code.
class Target {
    
    func request() -> String {
        return "Target: The default target's behavior."
    }
}

/// The Adaptee contains some useful behavior, but its interface is incompatible
/// with the existing client code. The Adaptee needs some adaptation before the
/// client code can use it.
class Adaptee {
    
    public func specificRequest() -> String {
        return ".eetpadA eht fo roivaheb laicepS"
    }
}

/// The Adapter makes the Adaptee's interface compatible with the Target's
/// interface.
class Adapter: Target {
    private var adaptee: Adaptee
    
    init(_ adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    override func request() -> String {
        return "Adapter: (TRANSLATED) " + adaptee.specificRequest().reversed()
    }
}

/// The client code supports all classes that follow the Target interface.
class Client {
    // ...
    static func someClientCode(target: Target) {
        print(target.request())
    }
    // ...
}
