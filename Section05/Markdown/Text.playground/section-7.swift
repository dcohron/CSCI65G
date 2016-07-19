        let x = rect.origin.x + rect.size.width*0.1
        let y = rect.origin.y + rect.size.height*0.5 - ascender + descender + 1.0
        let w = rect.size.width*0.8
        let h = ascender - descender
        let o = NSStringDrawingOptions.UsesLineFragmentOrigin
        let textRect = CGRectMake(x, y, w, h)
        attributedString.drawWithRect(textRect, options: o, context: nil)
