class RectView : UIView {
    var rectColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            setNeedsDisplay()
        }
    }
