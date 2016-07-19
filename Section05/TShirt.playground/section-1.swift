// Playground - noun: a place where people can play

import UIKit
import Foundation
import CoreText


class ATPLogoView: UIView {
    override func drawRect(dirtyRect: CGRect) {
        let fontName = "MyriadPro-Semibold"
        let title = "Accidental Tech Podcast"
        let initials = "ATP"
        let rect = CGRectMake(CGPointZero.x, CGPointZero.y, self.bounds.size.height, self.bounds.size.width)
        let w = rect.size.width
        let offsetY = w * -0.07
        
        var ringRect = CGRectInset(rect, w * 0.08, w * 0.08)
        ringRect.origin.y += offsetY
        var ring = UIBezierPath(ovalInRect: ringRect)
        ring.lineWidth = ceil(w * 0.012)
        UIColor(white: 0.3, alpha: 1.0).setStroke()
        ring.stroke()
        
        var innerRingRect = CGRectInset(rect, w * 0.21, w * 0.21)
        innerRingRect.origin.y += offsetY
        var inner = UIBezierPath(ovalInRect: innerRingRect)
        inner.lineWidth = ceil(w * 0.007)
        UIColor(white: 0.7, alpha: 1.0).setStroke()
        inner.stroke()
        
        var pStyle = NSMutableParagraphStyle()
        pStyle.alignment = NSTextAlignment.Center;
        // Font MyriadPro not availale on iOS
        // So if we use it the NSDictionary gets a nil value in it, and it all
        // comes crashing down.
        let f = UIFont(name: "Gill Sans", size: w * 0.068)!
        let kan =  w * 0.0037
        var tAttributes = [ NSFontAttributeName : f,
            NSParagraphStyleAttributeName : pStyle,
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSKernAttributeName : kan
        ] as NSDictionary
        var titleRect = CGRectMake(0, w * 0.91, w, w * 0.09)
        let o = NSStringDrawingOptions.UsesLineFragmentOrigin
        
        var t = NSAttributedString(string: title.uppercaseString, attributes: tAttributes)
        t.drawWithRect(titleRect, options: o, context: nil)
        
        let bs = CGSize(width: w * 0.44, height: w * 0.19)
        var bOrigin = CGPoint(x: (w - bs.width) / 2.0, y: (w - bs.height) / 2.0)
        bOrigin.y += offsetY
        let b = CGRect(origin: bOrigin, size: bs)
        
        var cX = CGRectGetMidX(b)
        var cY = CGRectGetMidY(b);
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
        
        var a: NSMutableDictionary = tAttributes.mutableCopy() as NSMutableDictionary
        a[NSFontAttributeName] = UIFont(name: "Gill Sans", size: bs.height * 0.84)
        a[NSKernAttributeName] = bs.height * 0.04
        var r = CGRectInset(b, 0, 0.17 * bs.height)
        NSAttributedString(string: initials, attributes: a).drawWithRect(r, options: o, context: nil)
    }
}

var v = ATPLogoView(frame: CGRectMake(0, 0, 800, 800))
