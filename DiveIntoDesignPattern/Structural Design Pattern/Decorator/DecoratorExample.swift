//
//  DecoratorExample.swift
//  DiveIntoDesignPattern
//
//  Created by Phincon on 04/03/25.
//

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
