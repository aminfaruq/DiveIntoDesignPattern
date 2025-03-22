//
//  DecoratorExampleTest.swift
//  DiveIntoDesignPatternTests
//
//  Created by Phincon on 04/03/25.
//

import XCTest
import AppKit

protocol ImageEditor: CustomStringConvertible {
    func apply() -> NSImage
}

class ImageDecorator: ImageEditor {
    private var editor: ImageEditor

    required init(editor: ImageEditor) {
        self.editor = editor
    }

    func apply() -> NSImage {
        print(editor.description + " applies changes")
        return editor.apply()
    }

    var description: String {
        "ImageDecorator"
    }
}

extension NSImage: ImageEditor {
    func apply() -> NSImage {
        return self
    }

    public override var description: String {
        return "Image"
    }
}

class BaseFilter: ImageDecorator {
    fileprivate var filter: CIFilter?

    init(editor: ImageEditor, filterName: String) {
        self.filter = CIFilter(name: filterName)
        super.init(editor: editor)
    }
    
    required init(editor: ImageEditor) {
        fatalError("init(editor:) has not been implemented")
    }
    
    override func apply() -> NSImage {
        let image = super.apply()
        guard let ciImage = CIImage(data: image.tiffRepresentation!) else { return image }
        
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        guard let outputImage = filter?.outputImage else { return image }

        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return NSImage(cgImage: cgImage, size: image.size)
        }
        
        return image
    }

    override var description: String {
        "BaseFilter"
    }
}

class BlurFilter: BaseFilter {
    required init(_ editor: ImageEditor) {
        super.init(editor: editor, filterName: "CIGaussianBlur")
    }
    
    required init(editor: ImageEditor) {
        fatalError("init(editor:) has not been implemented")
    }
    
    func update(radius: Double) {
        filter?.setValue(radius, forKey: kCIInputRadiusKey)
    }

    override var description: String {
        return "BlurFilter"
    }
}

class ColorFilter: BaseFilter {
    required init(_ editor: ImageEditor) {
        super.init(editor: editor, filterName: "CIColorControls")
    }
    
    required init(editor: ImageEditor) {
        fatalError("init(editor:) has not been implemented")
    }
    
    func update(saturation: Double) {
        filter?.setValue(saturation, forKey: kCIInputSaturationKey)
    }

    func update(brightness: Double) {
        filter?.setValue(brightness, forKey: kCIInputBrightnessKey)
    }

    func update(contrast: Double) {
        filter?.setValue(contrast, forKey: kCIInputContrastKey)
    }

    override var description: String {
        return "ColorFilter"
    }
}

class Resizer: ImageDecorator {
    private var xScale: CGFloat
    private var yScale: CGFloat
    private var hasAlpha: Bool

    init(_ editor: ImageEditor, xScale: CGFloat = 1, yScale: CGFloat = 1, hasAlpha: Bool = false) {
        self.xScale = xScale
        self.yScale = yScale
        self.hasAlpha = hasAlpha
        super.init(editor: editor)
    }
    
    required init(editor: ImageEditor) {
        fatalError("init(editor:) has not been implemented")
    }
    
    override func apply() -> NSImage {
        let image = super.apply()
        let size = NSSize(width: image.size.width * xScale, height: image.size.height * yScale)

        let resizedImage = NSImage(size: size)
        resizedImage.lockFocus()
        image.draw(in: NSRect(origin: .zero, size: size), from: NSRect(origin: .zero, size: image.size), operation: .copy, fraction: 1.0)
        resizedImage.unlockFocus()

        return resizedImage
    }

    override var description: String {
        return "Resizer"
    }
}


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
