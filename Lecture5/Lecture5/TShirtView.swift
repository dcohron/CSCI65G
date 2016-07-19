//
//  TShirt.swift
//  Lecture5
//
//  Created by Van Simmons on 7/5/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit
import Foundation
import CoreText

@IBDesignable class TShirtView: UIView {
    
    override func drawRect(dirtyRect: CGRect) {
        let title = "Intro to Mobile Computing"
        let initials = "CSCI S-65g"
        let rect = CGRectMake(CGPointZero.x, CGPointZero.y, self.bounds.size.height, self.bounds.size.width)
        let w = rect.size.width
        let offsetY = w * -0.07
        
        var ringRect = CGRectInset(rect, w * 0.08, w * 0.08)
        ringRect.origin.y += offsetY
        let ring = UIBezierPath(ovalInRect: ringRect)
        ring.lineWidth = ceil(w * 0.012)
        UIColor(white: 0.3, alpha: 1.0).setStroke()
        ring.stroke()
        
        var innerRingRect = CGRectInset(rect, w * 0.21, w * 0.21)
        innerRingRect.origin.y += offsetY
        let inner = UIBezierPath(ovalInRect: innerRingRect)
        inner.lineWidth = ceil(w * 0.007)
        UIColor(white: 0.7, alpha: 1.0).setStroke()
        inner.stroke()
        
        let pStyle = NSMutableParagraphStyle()
        pStyle.alignment = NSTextAlignment.Center;
        
        // Font MyriadPro not availale on iOS
        // So if we use it the NSDictionary gets a nil value in it, and it all
        // comes crashing down.
        let f = UIFont(name: "Gill Sans", size: w * 0.05)!
        let kan =  w * 0.0037
        var tAttributes = [ NSFontAttributeName : f,
                            NSParagraphStyleAttributeName : pStyle,
                            NSForegroundColorAttributeName : UIColor.whiteColor(),
                            NSKernAttributeName : kan
            ]
        let titleRect = CGRectMake(0, w * 0.91, w, w * 0.09)
        let o = NSStringDrawingOptions.UsesLineFragmentOrigin
        
        let t = NSAttributedString(string: title.uppercaseString, attributes: tAttributes)
        t.drawWithRect(titleRect, options: o, context: nil)
        
        let bs = CGSize(width: w * 0.44, height: w * 0.19)
        var bOrigin = CGPoint(x: (w - bs.width) / 2.0, y: (w - bs.height) / 2.0)
        bOrigin.y += offsetY
        let b = CGRect(origin: bOrigin, size: bs)
        
        let cX = CGRectGetMidX(b)
        let cY = CGRectGetMidY(b);
        var transform = CGAffineTransformMakeTranslation(cX, cY)
        transform = CGAffineTransformRotate(transform, 0.5236)
        transform = CGAffineTransformTranslate(transform, -cX, -cY)
        CGContextConcatCTM(UIGraphicsGetCurrentContext(), transform)
        UIColor(red: 0.12, green: 0.25, blue: 0.4, alpha: 1.0).setFill()
        UIBezierPath(roundedRect: b, cornerRadius: 0.15).fill()
        
        // Not happy with this part. A `Dictionary` should be mutable if I define
        // it as a var, but somehow that doesn't seem to work.
        // e.g.
        //      titleAttributes[NSFontAttributeName] = UIFont(name: "Gill Sans", size: bs.height * 0.84)
        
        tAttributes[NSFontAttributeName] = UIFont(name: "Gill Sans", size: bs.height * 0.84)
        tAttributes[NSKernAttributeName] = bs.height * 0.04
        let r = CGRectInset(b, 0, 0.17 * bs.height)
        NSAttributedString(string: initials, attributes: tAttributes).drawWithRect(r, options: o, context: nil)
    }
}