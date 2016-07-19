    
var txt = "Whatever we like" {
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
        

        var attributedString = NSAttributedString(string: txt as String,
            attributes: brightAttributes as! [String : AnyObject])
        
