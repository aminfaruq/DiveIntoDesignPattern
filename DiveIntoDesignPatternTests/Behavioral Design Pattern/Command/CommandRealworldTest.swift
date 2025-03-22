//
//  CommandRealworldTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 23/03/25.
//

import Foundation
import XCTest

class DelayedOperation: Operation {
    
    private var delay: TimeInterval
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    override var isExecuting: Bool {
        get { return _executing }
        set {
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _executing : Bool = false

    override var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    private var _finished: Bool = false
    
    override func start() {
        
        guard delay > 0 else {
            _start()
            return
        }
        
        let deadline = DispatchTime.now() + delay
        DispatchQueue(label: "").asyncAfter(deadline: deadline, execute: {
            self._start()
        })
    }
    
    private func _start() {
        
        guard !self.isCancelled else {
            print("\(self): operation is canceled")
            self.isFinished = true
            return
        }
        
        self.isExecuting = true
        self.main()
        self.isExecuting = false
        self.isFinished = true
    }
}

class WindowOperation: DelayedOperation {
    
    override func main() {
        print("\(self): Windows are closed view HomeKit.")
    }
    
    override var description: String { return "WindowOperation" }
}

class DoorOperation: DelayedOperation {
    
    override func main() {
        print("\(self): Doors are closed via HomeKit.")
    }
    
    override var description: String { return "DoorOperation" }
}

class TaxiOperation: DelayedOperation {
    
    override func main() {
        print("\(self): Taxi is ordered via Uber")
    }
    
    override var description: String { return "TaxiOperation" }
}

class CommandRealworldTest: XCTestCase {
    
    func test_CommandRealWord() {
        prepareTestEnvironment {
            
            let siri = SiriShortcuts.shared
            
            print("User: Hey Siri: I am leaving my home")
            siri.perform(.leaveHome)
            
            print("User: Hey Siri, I am leaving my work in 3 minutes")
            siri.perform(.leaveWork, delay: 3) /// for simplicity, we use seconds
            
            print("User: Hey Siri, I an still working")
            siri.cancel(.leaveWork)
        }
    }
}

extension CommandRealworldTest {
    
    struct ExecutionTime {
        static let max: TimeInterval = 5
        static let waiting: TimeInterval = 4
    }
    
    func prepareTestEnvironment(_ execution: () -> ()) {
        /// This method tells Xcode to wait for async operations. Otherwise the
        /// main test is done immediately.
        
        let expectation = self.expectation(description: "Expectation for async operations")
        
        let deadline = DispatchTime.now() + ExecutionTime.waiting
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
            expectation.fulfill()
        })
        
        execution()
        
        wait(for: [expectation], timeout: ExecutionTime.max)
    }
}

class SiriShortcuts {

    static let shared = SiriShortcuts()
    private lazy var queue = OperationQueue()

    private init() {}

    enum Action: String {
        case leaveHome
        case leaveWork
    }

    func perform(_ action: Action, delay: TimeInterval = 0) {
        print("Siri: performing \(action)-action\n")
        switch action {
        case .leaveHome:
            add(operation: WindowOperation(delay: delay))
            add(operation: DoorOperation(delay: delay))
        case .leaveWork:
            add(operation: TaxiOperation(delay: delay))
        }
    }

    func cancel(_ action: Action) {
        print("Siri: canceling \(action)-action\n")
        switch action {
        case .leaveHome:
            cancelOperation(with: WindowOperation.self)
            cancelOperation(with: DoorOperation.self)
        case .leaveWork:
            cancelOperation(with: TaxiOperation.self)
        }
    }

    private func cancelOperation(with operationType: Operation.Type) {
        queue.operations.filter { operation in
            return type(of: operation) == operationType
        }.forEach({ $0.cancel() })
    }

    private func add(operation: Operation) {
        queue.addOperation(operation)
    }
}
