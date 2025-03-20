//
//  ProxyExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 11/03/25.
//

import XCTest

final class ProxyExampleTests: XCTestCase {
    /// Proxy Design Pattern
    ///
    /// Intent: Provide a surrogate or placeholder for another object to control
    /// access to the original object or to add other responsibilities.
    ///
    /// Example: There are countless ways proxies can be used: caching, logging,
    /// access control, delayed initialization, etc.
    
    func testProxyRealWorld() {
        
        print("Client: Loading a profile WITHOUT proxy")
        loadBasicProfile(with: Keychain())
        loadProfileWithBankAccount(with: Keychain())
        
        print("\nClient: Let's load a profile WITH proxy")
        loadBasicProfile(with: ProfileProxy())
        loadProfileWithBankAccount(with: ProfileProxy())
    }
    
    func loadBasicProfile(with service: ProfileService) {
        
        service.loadProfile(with: [.basic], success: { profile in
            print("Client: Basic profile is loaded")
        }) { error in
            print("Client: Cannot load a basic profile")
            print("Client: Error: " + error.localizedSummary)
        }
    }
    
    func loadProfileWithBankAccount(with service: ProfileService) {
        
        service.loadProfile(with: [.basic, .bankAccount], success: { profile in
            print("Client: Basic profile with a bank account is loaded")
        }) { error in
            print("Client: Cannot load a profile with a bank account")
            print("Client: Error: \(error.localizedSummary)")
        }
    }
    
}
