//
//  UIImage+Ext.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/6.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

extension UIImage {
    
    // Set Filter with default value
    func setFilterDefault(name: String) -> UIImage?{
        
        let ciImage = CIImage(image: self)
        
        if let filter = CIFilter(name: name){
            
            filter.setDefaults()
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            if let outputImage = filter.outputImage, let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
                
                let image = UIImage(cgImage: cgImage)
                //let image = UIImage(ciImage: outputImage)
                return image
            }
        }
        return nil
    }
    
    // UIImage Resize
    func imageResize(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return image
    }
    
    // 照片轉向
    func fixOrientation() -> UIImage
    {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(Double.pi));
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0);
            transform = transform.rotated(by: CGFloat(Double.pi / 2));
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height);
            transform = transform.rotated(by: CGFloat(-Double.pi / 2));
        case .up, .upMirrored:
            break
        default:
            break
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1);
        default:
            break;
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        let ctx = CGContext(
            data: nil,
            width: Int(self.size.width),
            height: Int(self.size.height),
            bitsPerComponent: self.cgImage!.bitsPerComponent,
            bytesPerRow: 0,
            space: self.cgImage!.colorSpace!,
            bitmapInfo: UInt32(self.cgImage!.bitmapInfo.rawValue)
        )
        
        ctx!.concatenate(transform);
        
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx?.draw(self.cgImage!, in: CGRect(x:0 ,y: 0 ,width: self.size.height ,height:self.size.width))
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x:0 ,y: 0 ,width: self.size.width ,height:self.size.height))
            break;
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg = ctx!.makeImage()
        let img = UIImage(cgImage: cgimg!)
        
        return img;
    }
}
