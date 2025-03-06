//
//  FlyweightConceptual.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 06/03/25.
//

/// Flyweight Design Pattern
///
/// Intent: Lets you fit more objects into the available amount of RAM by
/// sharing common parts of state between multiple objects, instead of keeping
/// all of the data in each object.
class Flyweight {
    private let sharedState: [String]
    
    init(sharedState: [String]) {
        self.sharedState = sharedState
    }
    
    func operation(uniqueState: [String]) {
        print("Flyweight: Displaying shared (\(sharedState)) and unique (\(uniqueState) state.\n")
    }
}

/// The Flyweight Factory creates and manages the Flyweight objects. It ensures
/// that flyweights are shared correctly. When the client requests a flyweight,
/// the factory either returns an existing instance or creates a new one, if it
/// doesn't exist yet.
class FlyweightFactory {
    
    private var flyweights: [String: Flyweight]
    
    init(states: [[String]]) {
        
        var flyweights = [String: Flyweight]()
        
        for state in states {
            flyweights[state.key] = Flyweight(sharedState: state)
        }
        
        self.flyweights = flyweights
    }
    
    /// Returns an existing Flyweight with a given state or creates a new one.
    func flyweight(for state: [String]) -> Flyweight {
        
        let key = state.key

        guard let foundFlyweight = flyweights[key] else {
            print("FlyweightFactory: Can't find a flyweight, creating new one.\n")
            let flyweight = Flyweight(sharedState: state)
            flyweights.updateValue(flyweight, forKey: key)
            return flyweight
        }
        print("FlyweightFactory: Reusing existing flyweight.\n")
        return foundFlyweight
    }
    
    func printFlyweights() {
        print("FlyweightFactory: I have \(flyweights.count) flyweights:\n")
        for item in flyweights {
            print(item.key)
        }
    }
}

extension Array where Element == String {
    /// Returns a Flyweight's string hash for a given state.
    var key: String {
        self.joined()
    }
}
