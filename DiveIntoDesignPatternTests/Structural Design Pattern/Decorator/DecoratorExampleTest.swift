//
//  DecoratorExampleTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Phincon on 04/03/25.
//

import XCTest

final class DecoratorExampleTest: XCTestCase {

    func test_DecoratorRealworld() {
        let image = loadImage()
        
        print("Client: set up an editors stack")
        let resizer = Resizer(image, xScale: 0.2, yScale: 0.2)
        
        let blurFilter = BlurFilter(resizer)
        blurFilter.update(radius: 2)
        
        let colorFilter = ColorFilter(blurFilter)
        colorFilter.update(contrast: 0.53)
        colorFilter.update(brightness: 0.12)
        colorFilter.update(saturation: 4)
        
        clientCode(editor: colorFilter)
    }
    
    func clientCode(editor: ImageEditor) {
        let image = editor.apply()
        
        /// Note. You can stop an execution in xcode to see an image preview
        print("Client: all changes have been applied for \(image)")
    }
    
    //MARK: Helpers
    func loadImage() -> NSImage {
        let urlString = "https://refactoring.guru/images/content-public/logos/logo-new-3x.png"

        /// Note:
        /// Do not download images the following way in a production code.
        guard let url = URL(string: urlString) else {
            fatalError("Please enter a valid URL")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Cannot load an image")
        }

        guard let image = NSImage(data: data) else {
            fatalError("Cannot create an image from data")
        }
        return image
    }

}
