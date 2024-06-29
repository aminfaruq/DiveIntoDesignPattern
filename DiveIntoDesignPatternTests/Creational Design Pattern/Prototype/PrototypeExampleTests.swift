//
//  PrototypeExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 30/06/24.
//

import XCTest


final class PrototypeExampleTests: XCTestCase {
    
    func test_PrototypeRealWorld() {
        let author = Author(id: 10, username: "Amin")
        let page = Page(title: "My First Page", contents: "Hello world!", author: author)
        
        page.add(comment: Comment(message: "Keep it up!"))
        
        /// Since NSCopying returns Any, the copied object should be unwrapped.
        guard let anotherPage = page.copy() as? Page else {
            XCTFail("Page was not copied")
            return
        }
        
        /// Comments should be empty as it is a new page.
        XCTAssert(anotherPage.comments.isEmpty)
        
        /// Note that the author is now referencing two objects.
        XCTAssert(author.pagesCount == 2)

        print("Original title: " + page.title)
        print("Copied title: " + anotherPage.title)
        print("Count of pages: " + String(author.pagesCount))
    }
}
