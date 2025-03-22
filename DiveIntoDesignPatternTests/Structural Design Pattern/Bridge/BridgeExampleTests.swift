//
//  BridgeExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 27/02/25.
//

import XCTest
import AppKit

protocol SharingSupportable {
    /// Abstraction
    func accept(service: SharingService)
    
    func update(content: Content)
}

class BaseViewController: NSViewController, SharingSupportable {
    
    fileprivate var shareService: SharingService?

    func accept(service: SharingService) {
        shareService = service
    }
    
    func update(content: Content) {
        /// ...updating UI and showing a content...
        /// ...
        /// ... then, a user will choose a content and trigger an event
        print("\(description): User selected a \(content) to share")
        /// ...
        shareService?.share(content: content)
    }
}

class PhotoViewController: BaseViewController {
    /// Custom UI features
    
    override var description: String { "PhotoViewController" }
}

class FeedViewController: BaseViewController {
    /// Custom UI and features
    
    override var description: String { return "FeedViewController" }
}

protocol SharingService {
    /// Implementation
    func share(content: Content)
}

class FacebookSharingService: SharingService {
    
    func share(content: Content) {
        /// Use Facebook API to share a content
        print("Service: \(content) was posted to the facebook")
    }
}

class InstagramSharingService: SharingService {

    func share(content: Content) {

        /// Use Instagram API to share a content
        print("Service: \(content) was posted to the Instagram", terminator: "\n\n")
    }
}

protocol Content: CustomStringConvertible {
    
    var title: String { get }
    var images: [NSImage] { get }
}

struct FoodDomainModel: Content {
    
    var title: String
    var images: [NSImage]
    var calories: Int
    
    var description: String {
        return "Food Model"
    }
}


final class BridgeExampleTests: XCTestCase {
    
    func test_bridgeRealWorld() {
        
        print("Client: Pushing Photo View Controller...")
        push(PhotoViewController())
        
        print()
        
        print("Client: Pushing Feed View Controller...")
        push(FeedViewController())
    }
    
    func push(_ container: SharingSupportable) {
        let instagram = InstagramSharingService()
        let facebook = FacebookSharingService()
        
        container.accept(service: instagram)
        container.update(content: foodModel)
        
        container.accept(service: facebook)
        container.update(content: foodModel)
    }
    
    var foodModel: Content {
        FoodDomainModel(title: "This food is so various and delicious!", images: [NSImage(), NSImage()], calories: 47)
    }
}
