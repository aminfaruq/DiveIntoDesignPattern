//
//  FactoryMethodExample.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 28/06/24.
//

import Foundation

//MARK: - STEP 1 -
protocol Projector {
    
    /// Abstract projector interface
    
    var currentPage: Int { get }
    
    func present(info: String)
    
    func sync(with projector: Projector)
    
    func update(with page: Int)
}

extension Projector {
    /// Base implementation of Projector methods
    
    func sync(with projector: Projector) {
        projector.update(with: currentPage)
    }
}

//MARK: - STEP 2 -
class WifiProjector: Projector {
    var currentPage: Int = 0
    
    func present(info: String) {
        print("Info is presented over Wifi: \(info)")
    }
    
    func update(with page: Int) {
        /// ... scroll page via WiFi connection
        /// ...
        currentPage = page
    }
}

class BluetoothProjector: Projector {
    var currentPage: Int = 0
    
    func present(info: String) {
        print("Info is presented over Wifi: \(info)")
    }
    
    func update(with page: Int) {
        /// ... scroll page via WiFi connection
        /// ...
        currentPage = page
    }
}

//MARK: - STEP 3 -
protocol ProjectorFactory {
    func createProjector() -> Projector
    
    func syncedProjector(with projector: Projector) -> Projector
}

extension ProjectorFactory {
    
    /// Base implementation of ProjectorFactory
    func syncedProjector(with projector: Projector) -> Projector {
        
        /// Every instance creates an own projector
        let newProjector = createProjector()
        
        /// sync projectors
        newProjector.sync(with: projector)
        
        return newProjector
    }
}

//MARK: - STEP 4 -
class WifiFactory: ProjectorFactory {
    
    func createProjector() -> Projector {
        return WifiProjector()
    }
}

class BluetoothFactory: ProjectorFactory {
    
    func createProjector() -> Projector {
        return BluetoothProjector()
    }
}
