//
//  FlyweightExampleTest.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 06/03/25.
//

import AppKit

enum Type: String {
    case cat
    case dog
}

class Cell {
    
    private var animal: Animal?
    
    func update(with animal: Animal) {
        self.animal = animal
        let type = animal.type.rawValue
        let photos = "photos \(animal.appearance.photos.count)"
        print("Cell: Updating an appearance of a \(type)-cell: \(photos)\n")
    }
}

struct Animal: Equatable {
    /// This is an external context that contains specific values and an object
    /// with a common state.
    ///
    /// Note: The object of appearance will be lazily created when it is needed
    
    let name: String
    let country: String
    let type: Type
    
    var appearance: Appearance {
        return AppearanceFactory.appearance(for: type)
    }
    
}

struct Appearance: Equatable {
    
    /// This object contains a predefined appereance of every cell
    
    let photos: [NSImage]
    let backgroundColor: NSColor
}

extension Animal: CustomStringConvertible {
    
    var description: String {
        return "\(name), \(country), \(type.rawValue) + \(appearance.description)"
    }
}

extension Appearance: CustomStringConvertible {
    
    var description: String {
        return "photos: \(photos.count), \(backgroundColor)"
    }
}


class AppearanceFactory {

    private static var cache = [Type: Appearance]()

    static func appearance(for key: Type) -> Appearance {

        guard cache[key] == nil else {
            print("AppearanceFactory: Reusing an existing \(key.rawValue)-appearance.")
            return cache[key]!
        }

        print("AppearanceFactory: Can't find a cached \(key.rawValue)-object, creating a new one.")

        switch key {
        case .cat:
            cache[key] = catInfo
        case .dog:
            cache[key] = dogInfo
        }

        return cache[key]!
    }
}

extension AppearanceFactory {

    private static var catInfo: Appearance {
        return Appearance(photos: [NSImage()], backgroundColor: .red)
    }

    private static var dogInfo: Appearance {
        return Appearance(photos: [NSImage(), NSImage()], backgroundColor: .blue)
    }
}
