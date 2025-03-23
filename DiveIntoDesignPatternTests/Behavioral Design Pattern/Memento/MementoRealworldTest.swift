//
//  MementoRealworldTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 23/03/25.
//

import XCTest
import AppKit

class MementoRealWorld: XCTestCase {
    
    func test() {
        let textView = NSTextView()
        let undoStack = UndoStack(textView)
        
        textView.string = "First Change"
        undoStack.save()
        
        textView.string = "Second Change"
        undoStack.save()
        
        textView.string += " & Third Change"
        textView.textColor = NSColor.red
        undoStack.save()
        
        print(undoStack)
        
        print("Client: Perform Undo operation 2 times\n")
        undoStack.undo()
        undoStack.undo()
        
        print(undoStack)
    }
}

class UndoStack: CustomStringConvertible {
    private lazy var mementos = [MementoExample]()
    private let textView: NSTextView
    
    init(_ textView: NSTextView) {
        self.textView = textView
    }
    
    func save() {
        mementos.append(textView.memento)
    }
    
    func undo() {
        guard !mementos.isEmpty else { return }
        textView.restore(with: mementos.removeLast())
    }
    
    var description: String {
        return mementos.reduce("", { $0 + $1.description })
    }
}

protocol MementoExample: CustomStringConvertible {
    var text: String { get }
    var date: Date { get }
}

extension NSTextView {
    var memento: MementoExample {
        return TextViewMemento(text: string, textColor: textColor)
    }
    
    func restore(with memento: MementoExample) {
        guard let textViewMemento = memento as? TextViewMemento else { return }
        string = textViewMemento.text
        textColor = textViewMemento.textColor
    }
    
    struct TextViewMemento: MementoExample {
        let text: String
        let date = Date()
        let textColor: NSColor?
        
        var description: String {
            let time = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: date)
            let color = String(describing: textColor)
            return "Text: \(text)\n" + "Date: \(time.description)\n" + "Color: \(color)\n\n"
        }
    }
}
