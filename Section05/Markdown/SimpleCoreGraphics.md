### Simple Core Graphics
This example shows the use of some fairly simple core graphics API.  We:

1. write a subclass of UIView which partitions itself into an 3x3 array of rectangles and fills the center rectangle with a particular color. 
2. embed this view in a larger view which in turn puts a shadow effect around the inner view.  
3. round the corners of the inner view.
4. embed the shadow view in a view which wraps the entire hierarchy.

```swift
import Foundation
import UIKit
import CoreGraphics

```
Start defining our view. Note the fact that whenever we change a value on a property of the view, we need to mark the view as needing display.  Exercise: comment this out and observe what happens.

```swift
class RectView : UIView {
    var rectColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
```
drawRect(rect:) is the critical drawing method of a UIView.  It is called only when there is a valid CGGraphicsContext available and with the rect which needs redrawing.

```swift
    override func drawRect(rect: CGRect) {
        let x = rect.origin.x + rect.size.width/3.0
        let y = rect.origin.y + rect.size.height/3.0
        let w = rect.size.width/3.0
        let h = rect.size.height/3.0
        let centerRect = CGRectMake(x,y,w,h)

        let c = UIGraphicsGetCurrentContext()

```
This is where we pick the central rectangle.  It consumes 60% of the height and width and is located in the center of the current drawing rectangle.  Note that we are working in the redraw coordinate rect, NOT the frame of the view, but that for this example those two things are the same.  We start by outlining the central rect in red, then filling the total rect with blue then filling the inner rect with the specified color.

```swift
        CGContextAddRect(c, centerRect)
        CGContextSetStrokeColorWithColor(c , UIColor.redColor().CGColor)
        CGContextSetLineWidth(c,4.0)
        CGContextStrokePath(c)
        CGContextSetFillColorWithColor(c, rectColor.CGColor)
        CGContextFillRect(c, centerRect)
    }
}

```
Set up the outer and inner rects to use

```swift
let perimeter:CGFloat = 800.0
let outerSize = CGSizeMake(perimeter, perimeter)
let rect = CGRectMake(outerSize.width*0.125, outerSize.height*0.125,
    outerSize.width*0.75, outerSize.height*0.75)

```
Create the outer wrapping view

```swift
let superview = UIView(frame: CGRectMake(0, 0, outerSize.width, outerSize.height))

```
Create the view which will hold the shadows view.  Note that we directly access properties of the CALayer to create the shadow effect.

```swift
let shadowView = UIView(frame: rect)
shadowView.layer.shadowColor = UIColor.blackColor().CGColor
shadowView.layer.shadowOffset = CGSizeZero
shadowView.layer.shadowOpacity = 0.7
shadowView.layer.shadowRadius = 50

```
Create the inner view.  We then change a lot of its characteristics by adjusting properties of its layer as well.  Creating interesting UI requires both drawing and property manipulation.  Note that property manipulation is NOT done in the drawRect(rect:) method.  There are two reasons for this:

1. By then it’s too late, you are already drawing on the CALayer
2. Drawing is expensive and is done A LOT.  You want you drawRect() methods to be as small as possible

```swift
let view = RectView(frame: shadowView.bounds)
view.backgroundColor = UIColor.whiteColor()
view.layer.cornerRadius = 150.0
view.layer.borderColor = UIColor.grayColor().CGColor
view.layer.borderWidth = 0.5
view.clipsToBounds = true

```
Add the subviews to create the hierarchy we need

```swift
shadowView.addSubview(view)
superview.addSubview(shadowView)

```
Begin adjusting corner radii and colors.  You should experiment with this part of the code extensively.

```swift
view.backgroundColor = UIColor.whiteColor()
superview.setNeedsDisplay()
view.rectColor = UIColor(red: 1.0, green: 1.0, blue: 0, alpha: 0.2)
view.layer.cornerRadius = perimeter*0.75/8.0
superview.setNeedsDisplay()
view.layer.cornerRadius = perimeter*0.75/4.0
view.rectColor = UIColor(red: 1.0, green: 1.0, blue: 0, alpha: 0.8)
superview.setNeedsDisplay()
view.layer.cornerRadius = perimeter*0.75/2.0
view.rectColor = UIColor(red: 0.0, green: 1.0, blue: 0.5, alpha: 0.8)
superview.setNeedsDisplay()
```
