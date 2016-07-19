### Working with CGPaths
In this example we create a gauge-like view with discrete sections.  The number of sections can be specified and a drawing rectangle  We will:

1. Outline each section
2. Outline the over all view 
3. Outline an ‘up-to’ section
4. Fill the inside of the gauge with a different color
5. Embed the gauge in a background view which produces a CGGradient

```swift
import Foundation
import UIKit
import CoreGraphics
import Section05Views

let rect = CGRectMake(0, 0, 800, 800)

let NoOfSections = 8
let π:CGFloat = CGFloat(M_PI)

class CounterView: UIView {

```
Note again that when we update properties on subclasses of UIView, we generally will need to set the needsDisplay flag on the view so that it can be scheduled for to be redrawn.

```swift
var counter: Int = 5 {
        didSet {
                setNeedsDisplay()
        }
    }

    var outlineColor: UIColor = UIColor.blueColor()
    var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x:self.bounds.width/2, y: self.bounds.height/2)
        let radius:CGFloat = min(self.bounds.width-20, self.bounds.height-20)
        let arcWidth:CGFloat = 76
        let startAngle:CGFloat = 2.5 * π / 4
        let endAngle:CGFloat = 1.5 * π / 4
        
``` 
Create a Bezier path for the interior of the gauge

```swift
        var path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference:CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerSection = angleDifference / CGFloat(NoOfSections)
        let outlineEndAngle = arcLengthPerSection * CGFloat(counter) + startAngle

``` 
Create a Bezier path for the outline of the gauge

```swift
        var outlinePath = UIBezierPath(arcCenter: center,
            radius: radius/2 - 2.5,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true)

        outlinePath.addArcWithCenter(center,
            radius: radius/2 - arcWidth + 2.5,
            startAngle: outlineEndAngle,
            endAngle: startAngle,
            clockwise: false)
        
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
    }
}

```
Create the Background view and specify a gradient

```swift
class BackgroundView:UIView {    
    var lightGradientColor = UIColor(red:0.8, green:0.8, blue:0.1, alpha:1.0)
    var darkGradientColor  = UIColor(red:0.1, green:0.1, blue:0.1, alpha:1.0)
    var locations:[CGFloat] = [0.0, 1.0]

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        var colors:CFArrayRef = [lightGradientColor.CGColor,darkGradientColor.CGColor]
        
        var colorSpc:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB();
        var gradient:CGGradientRef   = CGGradientCreateWithColors(colorSpc, colors, locations);
        
        var context = UIGraphicsGetCurrentContext()
        CGContextDrawLinearGradient(context,
            gradient,
            CGPointMake(0.5, 0.0),
            CGPointMake(0.5, self.frame.size.height),
            3);
    }
}

```
Play with the views we have created

```swift
var bView = BackgroundView(frame:rect)
var view = CounterView(frame: rect)
view.backgroundColor = UIColor.clearColor()
bView.addSubview(view)
view.counter = 4
bView.setNeedsDisplay()
view.counter = 1
bView.setNeedsDisplay()
view.counter = 8
bView.setNeedsDisplay()

```



