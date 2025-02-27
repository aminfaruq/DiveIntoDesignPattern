//
//  BridgeExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 27/02/25.
//

import XCTest

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
