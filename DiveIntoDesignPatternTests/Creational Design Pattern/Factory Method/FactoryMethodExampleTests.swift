//
//  FactoryMethodExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/06/24.
//

import XCTest
import DiveIntoDesignPattern

private class ClientCode {
    private var currentProjector: Projector?
    
    func present(info: String, with factory: ProjectorFactory) {
        /// Check wheater a client code already present smth...
        
        guard let projector = currentProjector else {
            
            /// 'currentProjector' variable is nil. Create a new projector and
            /// start presentation.
            
            let projector = factory.createProjector()
            projector.present(info: info)
            self.currentProjector = projector
            return
        }
        
        /// Client code already has a projector. Let's sync pages of the old
        /// projector with a new one.
        
        self.currentProjector = factory.syncedProjector(with: projector)
        self.currentProjector?.present(info: info)
    }
}

final class FactoryMethodExampleTests: XCTestCase {

    func test_FactoryMethodRealWorld() {
        let info = "Very important info of the presentation"

        let clientCode = ClientCode()

        /// Present info over WiFi
        clientCode.present(info: info, with: WifiFactory())

        /// Present info over Bluetooth
        clientCode.present(info: info, with: BluetoothFactory())
    }
}
