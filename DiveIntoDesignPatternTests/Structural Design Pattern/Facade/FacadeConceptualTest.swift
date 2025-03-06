//
//  FacadeConceptualTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 06/03/25.
//

import XCTest

final class FacadeConceptualTest: XCTestCase {

    func test_FacadeConceptual() {
        /// The client code may have some of the subsystem's objects already
        /// created. In this case, it might be worthwhile to initialize the
        /// Facade with these objects instead of letting the Facade create new
        /// instances.
        
        let subsystem1 = Subsystem1()
        let subsystem2 = Subsystem2()
        let facade = Facade(subsystem1: subsystem1, subsystem2: subsystem2)
        FacadeClient.clientCode(facade: facade)
    }

}
