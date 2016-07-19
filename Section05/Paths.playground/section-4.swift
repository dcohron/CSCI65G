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
        let arcWidth:CGFloat = 150
        let startAngle:CGFloat = 2.5 * π / 4
        let endAngle:CGFloat = 1.5 * π / 4
        
