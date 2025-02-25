//
//  AdapterExample.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 25/02/25.
//

/// Adapter Design Pattern
///
/// Intent: Convert the interface of a class into the interface clients expect.
/// Adapter lets classes work together that couldn't work otherwise because of
/// incompatible interfaces.
import AppKit

protocol AuthService {
    
    func presentAuthFlow(from viewController: NSViewController)
}

class FacebookAuthSDK {
    
    func presentAuthFlow(from viewController: NSViewController) {
        /// Call SDK methods and pass a view controller
        print("Facebook WebView has been shown.")
    }
}

class TwitterAuthSDK {
    
    func startAuthorization(with viewController: NSViewController) {
        /// Call SDK methods and pass a view controller
        print("Twitter WebView has been shown. Users will be happy :)")
    }
}

extension TwitterAuthSDK: AuthService {
    /// This is an adapter
    ///
    /// Yeah, we are able to not create another class and just extend an
    /// existing one
    
    func presentAuthFlow(from viewController: NSViewController) {
        print("The Adapter is called! Redirecting to the original method...")
        self.startAuthorization(with: viewController)
    }
}

extension FacebookAuthSDK: AuthService {
    /// This extension just tells a compiler that both SDKs have the same
    /// interface.
}
