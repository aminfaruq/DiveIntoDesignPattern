//
//  AbstractFactoryExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 28/06/24.
//

import XCTest
import AppKit
import DiveIntoDesignPattern

private class ClientCode {
    
    private var currentController: AuthViewController?
    
    private lazy var windowController: NSWindowController = {
        guard let vc = currentController else { return NSWindowController() }
        let window = NSWindow(contentViewController: vc)
        return NSWindowController(window: window)
    }()
    
    private let factoryType: AuthViewFactory.Type
    
    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }
    
    /// MARK: - Presentation
    
    func presentLogin() {
        let controller = factoryType.authController(for: .login)
        windowController.contentViewController = controller
        windowController.showWindow(nil)
    }
    
    func presentSignUp() {
        let controller = factoryType.authController(for: .signUp)
        windowController.contentViewController = controller
        windowController.showWindow(nil)
    }
    
    /// Other methods...
}

final class AbstractFactoryExampleTests: XCTestCase {

    func test_FactoryMethodRealWorld() {
        #if teacherMode
        let clientCode = ClientCode(factoryType: TeacherAuthViewFactory.self)
        #else
        let clientCode = ClientCode(factoryType: StudentAuthViewFactory.self)
        #endif
        
        //Present Login flow
        clientCode.presentLogin()
        print("Login screen has been presented")
        
        //Present Signup flow
        clientCode.presentSignUp()
        print("Sign up screen has been presented")
    }
}
