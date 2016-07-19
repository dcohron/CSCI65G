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
