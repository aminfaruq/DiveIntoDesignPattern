//
//  ObserverRealworld.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 11/04/25.
//

import AppKit
import XCTest

class ObserverRealWorld_AppKit: XCTestCase {
    
    func test() {
        
        let cartManager = CartManager()
        
        let toolbar = NSToolbar(identifier: "MainToolbar")
        let cartVC = CartViewController()
        
        cartManager.add(subscriber: toolbar)
        cartManager.add(subscriber: cartVC)
        
        let apple = Food(id: 111, name: "Apple", price: 10, calories: 20)
        cartManager.add(product: apple)
        
        let tShirt = Clothes(id: 222, name: "T-shirt", price: 200, size: "L")
        cartManager.add(product: tShirt)
        
        cartManager.remove(product: apple)
    }
}

// MARK: - CartSubscriber Protocol

protocol CartSubscriber: CustomStringConvertible {
    func accept(changed cart: [ProductObserver])
}

// MARK: - Product Protocol

protocol ProductObserver {
    var id: Int { get }
    var name: String { get }
    var price: Double { get }
    
    func isEqual(to product: ProductObserver) -> Bool
}

extension ProductObserver {
    func isEqual(to product: ProductObserver) -> Bool {
        return id == product.id
    }
}

// MARK: - Product Models

struct Food: ProductObserver {
    var id: Int
    var name: String
    var price: Double
    var calories: Int
}

struct Clothes: ProductObserver {
    var id: Int
    var name: String
    var price: Double
    var size: String
}

// MARK: - CartManager

class CartManager {
    private lazy var cart = [ProductObserver]()
    private lazy var subscribers = [CartSubscriber]()
    
    func add(subscriber: CartSubscriber) {
        print("CartManager: I’m adding a new subscriber: \(subscriber.description)")
        subscribers.append(subscriber)
    }
    
    func add(product: ProductObserver) {
        print("\nCartManager: I’m adding a new product: \(product.name)")
        cart.append(product)
        notifySubscribers()
    }
    
    func remove(subscriber filter: (CartSubscriber) -> Bool) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }
    
    func remove(product: ProductObserver) {
        guard let index = cart.firstIndex(where: { $0.isEqual(to: product) }) else { return }
        print("\nCartManager: Product '\(product.name)' is removed from the cart")
        cart.remove(at: index)
        notifySubscribers()
    }
    
    private func notifySubscribers() {
        subscribers.forEach { $0.accept(changed: cart) }
    }
}

// MARK: - AppKit Views as Subscribers

extension NSToolbar: CartSubscriber {
    func accept(changed cart: [ProductObserver]) {
        print("NSToolbar: Updating toolbar items")
    }
    
    open override var description: String {
        return "NSToolbar"
    }
}

class CartViewController: NSViewController, CartSubscriber {
    func accept(changed cart: [ProductObserver]) {
        print("CartViewController: Updating list view with products")
    }
    
    open override var description: String {
        return "CartViewController"
    }
}
