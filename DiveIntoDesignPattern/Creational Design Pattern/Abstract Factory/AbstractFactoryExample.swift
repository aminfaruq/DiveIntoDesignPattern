//
//  AbstractFactoryExample.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 28/06/24.
//

import AppKit
import Foundation

enum AuthType {
    case login
    case signUp
}

protocol AuthViewFactory {

    static func authView(for type: AuthType) -> AuthView
    static func authController(for type: AuthType) -> AuthViewController
}

class StudentAuthViewFactory: AuthViewFactory {

    static func authView(for type: AuthType) -> AuthView {
        print("Student View has been created")
        switch type {
            case .login: return StudentLoginView()
            case .signUp: return StudentSignUpView()
        }
    }

    static func authController(for type: AuthType) -> AuthViewController {
        let controller = StudentAuthViewController(contentView: authView(for: type))
        print("Student View Controller has been created")
        return controller
    }
}

class TeacherAuthViewFactory: AuthViewFactory {

    static func authView(for type: AuthType) -> AuthView {
        print("Teacher View has been created")
        switch type {
            case .login: return TeacherLoginView()
            case .signUp: return TeacherSignUpView()
        }
    }

    static func authController(for type: AuthType) -> AuthViewController {
        let controller = TeacherAuthViewController(contentView: authView(for: type))
        print("Teacher View Controller has been created")
        return controller
    }
}



protocol AuthView {

    typealias AuthAction = (AuthType) -> ()

    var contentView: NSView { get }
    var authHandler: AuthAction? { get set }

    var description: String { get }
}

class StudentSignUpView: NSView, AuthView {

    private class StudentSignUpContentView: NSView {

        /// This view contains a number of features available only during a
        /// STUDENT authorization.
    }

    var contentView: NSView = StudentSignUpContentView()

    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthView.AuthAction?

    override var description: String {
        return "Student-SignUp-View"
    }
}

class StudentLoginView: NSView, AuthView {

    private let emailField = NSTextField()
    private let passwordField = NSTextField()
    private let signUpButton = NSButton()

    var contentView: NSView {
        return self
    }

    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthView.AuthAction?

    override var description: String {
        return "Student-Login-View"
    }
}

class TeacherSignUpView: NSView, AuthView {

    class TeacherSignUpContentView: NSView {

        /// This view contains a number of features available only during a
        /// TEACHER authorization.
    }

    var contentView: NSView = TeacherSignUpContentView()

    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthView.AuthAction?

    override var description: String {
        return "Teacher-SignUp-View"
    }
}

class TeacherLoginView: NSView, AuthView {

    private let emailField = NSTextField()
    private let passwordField = NSTextField()
    private let loginButton = NSButton()
    private let forgotPasswordButton = NSButton()

    var contentView: NSView {
        return self
    }

    /// The handler will be connected for actions of buttons of this view.
    var authHandler: AuthView.AuthAction?

    override var description: String {
        return "Teacher-Login-View"
    }
}



class AuthViewController: NSViewController {

    fileprivate var contentView: AuthView

    init(contentView: AuthView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        return nil
    }
}

class StudentAuthViewController: AuthViewController {

    /// Student-oriented features
}

class TeacherAuthViewController: AuthViewController {

    /// Teacher-oriented features
}

