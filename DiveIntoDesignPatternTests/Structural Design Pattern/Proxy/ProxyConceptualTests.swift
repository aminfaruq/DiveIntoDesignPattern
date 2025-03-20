//
//  ProxyConceptualTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 11/03/25.
//

import XCTest

final class ProxyConceptualTests: XCTestCase {

    
    func test_proxy() {
        print("Client: Executing the client code with a real subject:")
        let realSubject = RealSubject()
        ProxyClient.clientCode(subject: realSubject)
        
        print("\nClient: Executing the same client code with a proxy:")
        let proxy = Proxy(realSubject)
        ProxyClient.clientCode(subject: proxy)
    }
}
