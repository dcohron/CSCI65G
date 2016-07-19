        
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextTranslateCTM(context, 0.0, -rect.size.height);
        attributedString = NSAttributedString(string: txt,
            attributes: dullAttributes)
        attributedString.drawWithRect(textRect, options: o, context: nil)
    }
}
