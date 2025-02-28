//
//  CompositeExample.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 28/02/25.
//

import AppKit

protocol CompositeRealWorldComponent {
    func accept<T: Theme>(theme: T)
}

extension CompositeRealWorldComponent where Self: NSViewController {
    func accept<T: Theme>(theme: T) {
        view.accept(theme: theme)
        view.subviews.forEach({ $0.accept(theme: theme) })
    }
}

extension NSView: CompositeRealWorldComponent {}
extension NSViewController: CompositeRealWorldComponent {}

extension CompositeRealWorldComponent where Self: NSView {
    func accept<T: Theme>(theme: T) {
        print("\t\(description): has applied \(theme.description)")
        layer?.backgroundColor = theme.backgroundColor.cgColor
    }
}

extension CompositeRealWorldComponent where Self: NSTextField {
    func accept<T: LabelTheme>(theme: T) {
        print("\t\(description): has applied \(theme.description)")
        backgroundColor = theme.backgroundColor
        textColor = theme.textColor
    }
}

extension CompositeRealWorldComponent where Self: NSButton {
    func accept<T: ButtonTheme>(theme: T) {
        print("\t\(description): has applied \(theme.description)")
        layer?.backgroundColor = theme.backgroundColor.cgColor
        contentTintColor = theme.textColor
    }
}

protocol Theme: CustomStringConvertible {
    var backgroundColor: NSColor { get }
}

protocol ButtonTheme: Theme {
    var textColor: NSColor { get }
    var highlightedColor: NSColor { get }
}

protocol LabelTheme: Theme {
    var textColor: NSColor { get }
}

/// Button Themes

struct DefaultButtonTheme: ButtonTheme {
    var textColor = NSColor.red
    var highlightedColor = NSColor.white
    var backgroundColor = NSColor.orange
    var description: String { return "Default Button Theme" }
}

struct NightButtonTheme: ButtonTheme {
    var textColor = NSColor.white
    var highlightedColor = NSColor.red
    var backgroundColor = NSColor.black
    var description: String { return "Night Button Theme" }
}

/// Label Themes

struct DefaultLabelTheme: LabelTheme {
    var textColor = NSColor.red
    var backgroundColor = NSColor.black
    var description: String { return "Default Label Theme" }
}

struct NightLabelTheme: LabelTheme {
    var textColor = NSColor.white
    var backgroundColor = NSColor.black
    var description: String { return "Night Label Theme" }
}


class WelcomeViewController: NSViewController {
    class ContentView: NSView {
        var titleLabel = NSTextField(labelWithString: "")
        var actionButton = NSButton(title: "", target: nil, action: nil)

        override init(frame: NSRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder decoder: NSCoder) {
            super.init(coder: decoder)
            setup()
        }

        func setup() {
            addSubview(titleLabel)
            addSubview(actionButton)
        }
    }

    override func loadView() {
        view = ContentView()
    }
}

/// Let's override a description property for better output

extension WelcomeViewController {
    open override var description: String { return "WelcomeViewController" }
}

extension WelcomeViewController.ContentView {
    override var description: String { return "ContentView" }
}

extension NSButton {
    open override var description: String { return "NSButton" }
}

extension NSTextField {
    open override var description: String { return "NSTextField" }
}
