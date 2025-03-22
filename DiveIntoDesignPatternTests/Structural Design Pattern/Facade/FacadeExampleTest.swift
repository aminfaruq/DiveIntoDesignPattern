//
//  FacadeExampleTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Amin faruq on 06/03/25.
//

import XCTest
import AppKit

/// Facade Design Pattern
///
/// Intent: Provides a simplified interface to a library, a framework, or any
/// other complex set of classes.

extension NSImageView {
    /// This extension plays a facade role.
    
    func downloadImage(at url: URL?) {
        print("Start downloading...")
        
        let placeholder = NSImage(named: "placeholder")
        
        ImageDownloader()
            .loadImage(at: url,
                       placeholder: placeholder) { image, error in
                print("Handle an image...")
                
                /// Crop, cache, apply filters, whatever...
                
                self.image = image
            }
    }
}

private class ImageDownloader {
    
    /// Third party library or your own solusion (subsystem)
    
    typealias Completion = (NSImage, Error?) -> ()
    typealias Progress = (Int, Int) -> ()
    
    func loadImage(at url: URL?,
                   placeholder: NSImage? = nil,
                   progress: Progress? = nil,
                   completion: Completion) {
        /// ... Set up a network stack
        /// ... Downloading an image
        /// ...
        completion(NSImage(), nil)
    }
}


final class FacadeExampleTest: XCTestCase {
    
    /// In the real project, you probably will use third-party libraries. For
    /// instance, to download images.
    ///
    /// Therefore, facade and wrapping it is a good way to use a third party API
    /// in the client code. Even if it is your own library that is connected to
    /// a project.
    ///
    /// The benefits here are:
    ///
    /// 1) If you need to change a current image downloader it should be done
    /// only in the one place of a project. A number of lines of the client code
    /// will stay work.
    ///
    /// 2) The facade provides an access to a fraction of a functionality that
    /// fits most client needs. Moreover, it can set frequently used or default
    /// parameters.
    
    func test_FacadeRealWorld() {
        let nsImageView = NSImageView()
        
        print("Let's set an image for the image view")
        
        clientCode(nsImageView)
        
        print("Image has been set")
        
        XCTAssertNotNil(nsImageView.image)
    }
    
    fileprivate func clientCode(_ nsImageView: NSImageView) {
        let url = URL(string: "www.example.com/logo")
        nsImageView.downloadImage(at: url)
    }
}
