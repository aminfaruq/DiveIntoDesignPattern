//
//  FlyweightExampleTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 06/03/25.
//

import XCTest

final class FlyweightExampleTest: XCTestCase {
    
    func test_flyweightRealWorld() {
        
        let maineCoon = Animal(name: "Maine Coon",
                               country: "USA",
                               type: .cat)
        
        let sphynx = Animal(name: "Sphynx",
                            country: "Egypt",
                            type: .cat)
        
        let bulldog = Animal(name: "Bulldog",
                             country: "England",
                             type: .dog)
        
        print("Client: I created a number of objects to display")
        
        /// Displaying objects for the 1-st time.
        
        print("Client: Let's show animals for the 1st time\n")
        display(animals: [maineCoon, sphynx, bulldog])
        
        /// Displaying objects for the 2-nd time.
        ///
        /// Note: Cached object of the appearance will be reused this time.
        
        print("\nClient: I have a new dog, let's show it the same way!\n")

        let germanShepherd = Animal(name: "German shepherd",
                                    country: "Germany",
                                    type: .dog)
        
        display(animals: [germanShepherd])
        
    }
    
    
    //MARK: Helpers
    
    func display(animals: [Animal]) {
        
        let cells = loadCells(count: animals.count)
        
        for index in 0..<animals.count {
            cells[index].update(with: animals[index])
        }
        
        /// using cells...
    }
    
    func loadCells(count: Int) -> [Cell] {
        // Emulates behaviour of table/collection view.
        return Array(repeating: Cell(), count: count)
    }
}
