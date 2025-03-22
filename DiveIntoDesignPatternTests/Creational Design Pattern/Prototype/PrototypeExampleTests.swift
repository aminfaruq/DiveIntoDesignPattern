//
//  PrototypeExampleTests.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 30/06/24.
//

import XCTest
import Foundation

class Author {
    private var id: Int
    private var username: String
    private var pages = [Page]()
    
    init(id: Int, username: String) {
        self.id = id
        self.username = username
    }
    
    func add(page: Page) {
        pages.append(page)
    }
    
    var pagesCount: Int { pages.count }
}

class Page: NSCopying {
    private(set) var title: String
    private(set) var contents: String
    private weak var author: Author?
    private(set) var comments = [Comment]()

    init(title: String, contents: String, author: Author?) {
        self.title = title
        self.contents = contents
        self.author = author
        author?.add(page: self)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Page(title: "Copy of '\(title)'" , contents: contents, author: author)
    }
    
    func add(comment: Comment) {
        comments.append(comment)
    }
}

struct Comment {
    let date = Date()
    let message: String
}


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
