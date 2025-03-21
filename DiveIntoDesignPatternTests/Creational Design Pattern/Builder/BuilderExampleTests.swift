//
//  BuilderExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 29/06/24.
//

import XCTest
import Foundation

class BaseQueryBuilder<Model: DomainModel> {
    typealias Predicate = (Model) -> (Bool)
    
    func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        return self
    }
    
    func filter(_ predicate: @escaping Predicate) -> BaseQueryBuilder<Model> {
        return self
    }
    
    func fetch() -> [Model] {
        preconditionFailure("Should be ovveridden in subclasess.")
    }
}

class RealmQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {
    enum Query {
        case filter(Predicate)
        case limit(Int)
        /// ...
    }
    
    private var operations = [Query]()
    
    @discardableResult
    override func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }
    
    @discardableResult
    override func filter(_ predicate: @escaping BaseQueryBuilder<Model>.Predicate) -> BaseQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }
    
    override func fetch() -> [Model] {
        print("RealmQueryBuilder: Initializing RealmDataProvider with \(operations.count) operation:")
        return RealmProvider().fetch(operations)
    }
}

class CoreDataQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {
    enum Query {
        case filter(Predicate)
        case limit(Int)
        case includesPropertyValues(Bool)
        /// ...
    }
    
    private var operations = [Query]()
    
    override func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }
    
    override func filter(_ predicate: @escaping BaseQueryBuilder<Model>.Predicate) -> BaseQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }
    
    func includesPropertyValues(_ toggle: Bool) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.includesPropertyValues(toggle))
        return self
    }
    
    override func fetch() -> [Model] {
        print("CoreDataQueryBuilder: Initializing CoreDataProvider with \(operations.count) operations.")
        return CoreDataProvider().fetch(operations)
    }
}

/// Data Providers contain a logic how to fetch models. Builders accumulate
/// operations and then update providers to fetch the data.
class RealmProvider {
    
    func fetch<Model: DomainModel> (_ operations: [RealmQueryBuilder<Model>.Query]) -> [Model] {
        
        print("RealmProvider: Retrieving data from Realm...")
        
        for item in operations {
            switch item {
            case .filter(_):
                print("RealmProvider: executing the 'filter' operation")
                /// Use Realm instance to filter results.
            case .limit(_):
                print("RealmProvider: executing the 'limit' operation.")
                /// Use Realm instance to limit results.
            }
        }
        /// Return results from result
        return []
    }
}

class CoreDataProvider {
    
    func fetch<Model: DomainModel>(_ operations: [CoreDataQueryBuilder<Model>.Query]) -> [Model] {
        /// Create a NSFetchRequest

        print("CoreDataProvider: Retirieving data from CoreData...")
        
        for item in operations {
            switch item {
            case .filter(_):
                print("CoreDataProvider: executing the 'filter' operation.")
                /// Set a 'predicate' for a NSFetchRequest.
            case .limit(_):
                print("CoreDataProvider: executing the 'limit' operation.")
                /// Set a 'fetchLimit' for a NSFetchRequest.
            case .includesPropertyValues(_):
                print("CoreDataProvider: executing the 'includesPropertyValues' operation.")
                /// Set an 'includesPropertyValues' for a NSFetchRequest.
            }
        }
        
        /// Execute a NSFetchRequest and return result.
        return []
    }
}

protocol DomainModel {
    /// The protocol groups domain models to the common interface
}

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

