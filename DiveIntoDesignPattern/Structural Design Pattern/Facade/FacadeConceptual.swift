//
//  FacadeConceptual.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 06/03/25.
//

/// The Facade class provides a simple interface to the complex logic of one or
/// several subsystems. The Facade delegates the client requests to the
/// appropriate objects within the subsystem. The Facade is also responsible for
/// managing their lifecycle. All of this shields the client from the undesired
/// complexity of the subsystem.
class Facade {
    
    private var subsystem1: Subsystem1
    private var subsystem2: Subsystem2
    
    /// Depending on your application's needs, you can provide the Facade with
    /// existing subsystem objects or force the Facade to create them on its
    /// own.
    init(subsystem1: Subsystem1 = Subsystem1(),
         subsystem2: Subsystem2 = Subsystem2()) {
        self.subsystem1 = subsystem1
        self.subsystem2 = subsystem2
    }
    
    /// The Facade's methods are convenient shortcuts to the sophisticated
    /// functionality of the subsystems. However, clients get only to a fraction
    /// of a subsystem's capabilities.
    func operation() -> String {
        
        var result = "Facade initializes subsystem:"
        result += " " + subsystem1.operation1()
        result += " " + subsystem2.operation1()
        result += "\n" + "Facade orders subsystems to perform the action:\n"
        result += " " + subsystem1.operationN()
        result += " " + subsystem2.operationZ()
        return result
    }
}

/// The Subsystem can accept requests either from the facade or client directly.
/// In any case, to the Subsystem, the Facade is yet another client, and it's
/// not a part of the Subsystem.
class Subsystem1 {
    
    func operation1() -> String {
        return "Sybsystem1: Ready!\n"
    }
    
    // ...
    
    func operationN() -> String {
        return "Subsystem1: Go!\n"
    }
}

/// Some facades can work with multiple subsystems at the same time.
class Subsystem2 {
    
    func operation1() -> String {
        return "Subsystem2: Get ready!\n"
    }
    
    // ...
    
    func operationZ() -> String {
        return "Subsystem2: Fire!\n"
    }
}

/// The client code works with complex subsystems through a simple interface
/// provided by the Facade. When a facade manages the lifecycle of the
/// subsystem, the client might not even know about the existence of the
/// subsystem. This approach lets you keep the complexity under control.
class FacadeClient {
    // ...
    static func clientCode(facade: Facade) {
        print(facade.operation())
    }
    // ...
}
