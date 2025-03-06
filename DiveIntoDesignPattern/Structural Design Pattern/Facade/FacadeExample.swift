//
//  FacadeExample.swift
//  DiveIntoDesignPattern
//
//  Created by Amin faruq on 06/03/25.
//

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
