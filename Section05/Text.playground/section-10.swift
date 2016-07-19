        
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextTranslateCTM(context, 0.0, -rect.size.height);
        attributedString = NSAttributedString(string: txt as String,
            attributes: dullAttributes as! [String : AnyObject])
        attributedString.drawWithRect(textRect, options: o, context: nil)
    }
}
