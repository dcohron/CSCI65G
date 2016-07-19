###Working with Text in CoreGraphics
In this example we will create a text box using CoreGraphics and then mirror that text and adjust it’s stroke alpha to give a nice effect

```swift
import Foundation
import UIKit
import CoreGraphics
import QuartzCore
import CoreText
import Section05Views

let rect = CGRectMake(0, 0, 800, 800)
let pStyle = NSMutableParagraphStyle()
let defaultFontSize:CGFloat = 64.0

class TextView: UIView {
    var rectColor = UIColor.lightGrayColor()

```
We choose this string in order to get several letters which descend below the baseline of the text.  I.e. qygpj.  This allows us to examine the various measurements involved in breaking text down for accurate alignment.

```swift
    
var txt: NSString = "Oy Vey, World! (qgpyj)" {
        didSet {
                setNeedsDisplay()
        }
    }

    var fontSize:CGFloat = defaultFontSize {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var descender:CGFloat = UIFont.systemFontOfSize(defaultFontSize).descender
    var ascender:CGFloat = UIFont.systemFontOfSize(defaultFontSize).ascender
    
    var brightAttributes:NSDictionary = [
        NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 1.0),
        NSParagraphStyleAttributeName : pStyle,
        NSFontAttributeName : UIFont.systemFontOfSize(defaultFontSize)
        ] {
        didSet {
            setNeedsDisplay()
        }
    }

    var dullAttributes:NSDictionary = [
        NSForegroundColorAttributeName : UIColor(white: 1.0, alpha: 0.4),
        NSParagraphStyleAttributeName : pStyle,
        NSFontAttributeName : UIFont.systemFontOfSize(defaultFontSize)
        ] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        pStyle.alignment = NSTextAlignment.Center
        var context = UIGraphicsGetCurrentContext()
        

        var attributedString = NSAttributedString(string: txt,
            attributes: brightAttributes)
        
```
Exercise for the reader.  Try to reconstruct how the font size is related to ascender and descender sizes.  Also note that descender is always negative, i.e. it goes below the baseline and this has an effect on drawing

```swift
	  ascender
        descender
        let textSize = txt.sizeWithAttributes(brightAttributes)

```
Exercise: Play with the various values used to determine x, y, w, and h

```swift
        let x = rect.origin.x + rect.size.width*0.1
        let y = rect.origin.y + rect.size.height*0.5 - ascender + descender + 1.0
        let w = rect.size.width*0.8
        let h = ascender - descender
        let o = NSStringDrawingOptions.UsesLineFragmentOrigin
        let textRect = CGRectMake(x, y, w, h)
        attributedString.drawWithRect(textRect, options: o, context: nil)

```
Exercise for the reader: explain why the code below accurately mirrors the text and turns it upside down.  Try moving the text group to various places on the screen

```swift
        
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextTranslateCTM(context, 0.0, -rect.size.height);
        attributedString = NSAttributedString(string: txt,
            attributes: dullAttributes)
        attributedString.drawWithRect(textRect, options: o, context: nil)
    }
}

```
Draw the view we have constructed

```swift
var tv = TextView(frame:rect)

```
