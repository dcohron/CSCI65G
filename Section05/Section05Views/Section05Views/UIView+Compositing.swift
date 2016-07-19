//
//  UIView+Compositing.swift
//  Section05Views
//
//  Created by Van Simmons on 2/16/15.
//  Copyright (c) 2015 ComputeCycles, LLC. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import CoreImage

public extension UIView {
    
    public func compositedImage() -> UIImage? {
        
        var image:UIImage? = nil
        
        let contentScale = UIScreen.mainScreen().scale
        let colorspace = CGColorSpaceCreateDeviceRGB();
        
        let w = self.frame.size.width * contentScale
        let h = self.frame.size.height * contentScale
        let uiw = Int(w)
        let uih = Int(h)
        let oldScale = self.contentScaleFactor
        self.contentScaleFactor = contentScale;
        let bmInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.NoneSkipLast.rawValue)
        let context = CGBitmapContextCreate(nil, uiw, uih, 8, Int(w*4), colorspace, bmInfo.rawValue)
        if context == nil {
            NSLog("Invalid context in drawToImage, width = %f, height = %f, row bytes = %f",
                self.frame.size.width, self.frame.size.height, self.frame.size.width * 4);
        }
        else {
            let xs:CGFloat = 1.0 * contentScale
            let ys:CGFloat = -(1.0 * contentScale);
            CGContextScaleCTM(context, xs, ys);
            CGContextTranslateCTM(context, 0.0, -h/contentScale);
                        
            self.layer.renderInContext(context!)
            
            let imageRef = CGBitmapContextCreateImage(context)
            image = UIImage(CGImage:imageRef!, scale:self.contentScaleFactor, orientation:UIImageOrientation.Up)
        }
        
        self.contentScaleFactor = oldScale;
        
        return image;
    }
    
}