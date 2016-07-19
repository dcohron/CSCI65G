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
