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
    func setFilterDefault(name: String) -> UIImage{
        
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
        return UIImage()
    }
    
    func applyFilter(filterName: String, attributes: Dictionary<String, FilterAttribute>) -> UIImage {
        let ciImage = CIImage(image: self)
        
        guard let filter = CIFilter(name: filterName) else { return self }
        
        for (key, attribute) in attributes {
            
            //let className = attribute.className
            if key == kCIInputImageKey {
                filter.setValue(ciImage, forKey: key)
            }
            else {
                filter.setValue(attribute.value, forKey: key)
            }
        }
        
        //if let outputImage = filter.outputImage, let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
        if let outputImage = filter.outputImage {
            //return UIImage(cgImage: outputImage)
            return UIImage(ciImage: outputImage)
        }
        
        return self
    }
    
    /*func setFilter(image: UIImage, filter: CIFilter, keys: [FilterAttributeAndKey]) -> UIImage{
        
        var returnImage = image
        
        let ciImage = CIImage(image: image)
        
        for key in keys {
            
            print("get key:\(key.attributeFilterKey)")
            print("get value:\(key.attributeDefault)")
            
            let forKey = key.attributeFilterKey
            let value = key.attributeDefault
            let type = key.attributeClass
            
            key.attributeSave = value
            
            // -- CIImage 另外處理
            if type == "CIImage"{
                switch forKey {
                case kCIInputImageKey:
                    filter.setValue(ciImage, forKey: forKey)
                case kCIInputMaskImageKey:
                    print("set inputMask")
                default:
                    break
                }
            }
            else if type == "NSNumber"{
                filter.setValue(value, forKey: forKey)
            }
        }
        
        //outputImage = UIImage(ciImage: filter.outputImage!)
        if let outputImage = filter.outputImage, let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
            returnImage = UIImage(cgImage: cgImage)
            print("filter set success")
        }
        
        return returnImage
    }
    
    func resetFilter(filter: CIFilter, forKey: String, value: Any) -> UIImage{
        var returnImage = UIImage()
        
        print("reset key:\(forKey) and value:\(value)")
        
        filter.setValue(value, forKey: forKey)
        
        if let outputImage = filter.outputImage, let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
            returnImage = UIImage(cgImage: cgImage)
        }
        
        return returnImage
    }*/
    
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
    
    // 設置圖片圓角
    func isRoundCorner(radius: CGFloat, corners: UIRectCorner) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        // 開始圖形上下文
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        // 繪製路徑
        UIGraphicsGetCurrentContext()?.addPath(UIBezierPath(roundedRect: rect,
                                                            byRoundingCorners: corners,
                                                            cornerRadii: CGSize(width: radius, height: radius)).cgPath)
        // 裁剪
        UIGraphicsGetCurrentContext()!.clip()
        // 將原圖片畫到圖型上下文內将原图片画到图形上下文
        self.draw(in: rect)
        UIGraphicsGetCurrentContext()!.drawPath(using: .fillStroke)
        guard let output = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        // 關閉上下文
        UIGraphicsEndImageContext()
        return output
    }
    
    func mergeWithImage(_ image: UIImage) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        
        self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
        image.draw(in: CGRect(origin: CGPoint(x:(self.size.width - image.size.width) / 2, y: (self.size.height - image.size.height) / 2), size: image.size))
        
        guard let output = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        
        UIGraphicsEndImageContext()
        
        return output
    }

}
