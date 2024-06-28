//
//  BuilderExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 29/06/24.
//

import XCTest

private struct User: DomainModel {
    let id: Int
    let age: Int
    let email: String
}

final class BuilderExampleTests: XCTestCase {
    
    func test_BuilderRealWorld() {
        print("Client: Start fetching data from Realm")
        makeClientCode(builder: RealmQueryBuilder<User>())
        
        print("Client: Start fetching data from CoreData")
        makeClientCode(builder: CoreDataQueryBuilder<User>())
    }
    
    private func makeClientCode(builder: BaseQueryBuilder<User>) {
        let results = builder.filter({ $0.age < 20 })
            .limit(1)
            .fetch()
        
        print("Client: I have fetched: " + String(results.count) + " records.")
    }
}

