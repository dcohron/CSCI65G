import Foundation
import UIKit
import CoreGraphics
import QuartzCore
import CoreText
import Section05Views

let rect = CGRectMake(0, 0, 800, 800)
let pStyle = NSMutableParagraphStyle()
let defaultFontSize:CGFloat = 64.0

class TextView: UIView {
    var rectColor = UIColor.lightGrayColor()
