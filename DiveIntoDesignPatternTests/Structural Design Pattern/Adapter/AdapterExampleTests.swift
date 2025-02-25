//
//  AdapterExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 25/02/25.
//

import XCTest
@testable import DiveIntoDesignPattern

final class AdapterExampleTests: XCTestCase {
    /// Example. Let's assume that our app perfectly works with Facebook
    /// authorization. However, users ask you to add sign in via Twitter.
    ///
    /// Unfortunately, Twitter SDK has a different authorization method.
    ///
    /// Firstly, you have to create the new protocol 'AuthService' and insert
    /// the authorization method of Facebook SDK.
    ///
    /// Secondly, write an extension for Twitter SDK and implement methods of
    /// AuthService protocol, just a simple redirect.
    ///
    /// Thirdly, write an extension for Facebook SDK. You should not write any
    /// code at this point as methods already implemented by Facebook SDK.
    ///
    /// It just tells a compiler that both SDKs have the same interface.
    
    func test_adapterRealWorld() {
        
        print("Starting an authorization via Facebook")
        startAuthorization(with: FacebookAuthSDK())
        
        print("Starting an authorization via Twitter.")
        startAuthorization(with: TwitterAuthSDK())
    }
    
    func startAuthorization(with service: AuthService) {
        
        /// The current top view controller of the app
        let topViewController = NSViewController()
        
        service.presentAuthFlow(from: topViewController)
    }
}
