        CGContextAddRect(c, centerRect)
        CGContextSetStrokeColorWithColor(c , UIColor.redColor().CGColor)
        CGContextSetLineWidth(c,4.0)
        CGContextStrokePath(c)
        CGContextSetFillColorWithColor(c, rectColor.CGColor)
        CGContextFillRect(c, centerRect)
    }
}
