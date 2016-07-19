    override func drawRect(rect: CGRect) {
        let x = rect.origin.x + rect.size.width/3.0
        let y = rect.origin.y + rect.size.height/3.0
        let w = rect.size.width/3.0
        let h = rect.size.height/3.0
        let centerRect = CGRectMake(x,y,w,h)

        let c = UIGraphicsGetCurrentContext()
