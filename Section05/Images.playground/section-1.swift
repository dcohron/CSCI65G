// Playground - noun: a place where people can play

import Foundation
import UIKit
import CoreGraphics
import CoreImage
import XCPlayground
import Section05Views

let rect = CGRectMake(0, 0, 360, 360)
let π:CGFloat = CGFloat(M_PI)
var v = CIVector(CGPoint: CGPointMake(180.0,180.0))
let black = UIColor.blackColor()
let ciBlack = CIColor(CGColor: black.CGColor)
let blue = UIColor.blueColor()
let ciBlue = CIColor(CGColor: blue.CGColor)

let img = UIImage(named: "Flower")!

var iv = UIImageView(frame:rect)
iv.image = img

var ctx = CIContext(options:nil)

var sfilter = CIFilter(name:"CISharpenLuminance")
sfilter!.setDefaults
sfilter!.setValue(0.8, forKey: "inputSharpness")
sfilter!.setValue(CIImage(image: img), forKey: kCIInputImageKey)
var sharpenedImage = ctx.createCGImage(sfilter!.outputImage!, fromRect:sfilter!.outputImage!.extent)
var filteredImage = UIImage(CGImage: sharpenedImage)
iv.image = filteredImage

var bfilter:CIFilter = CIFilter(name:"CIGaussianBlur")!
bfilter.setDefaults
bfilter.setValue(10.0,forKey:"inputRadius")
bfilter.setValue(CIImage(image: img), forKey: kCIInputImageKey)

var cgImage = ctx.createCGImage(bfilter.outputImage!, fromRect:bfilter.outputImage!.extent)
filteredImage = UIImage(CGImage: cgImage)

iv.image = filteredImage

var cfilter = CIFilter(name:"CICheckerboardGenerator")
cfilter!.setDefaults
cfilter!.setValue(v, forKey:"inputCenter")
cfilter!.setValue(
    
    
    
    20.0, forKey:"inputWidth")
cfilter!.setValue(ciBlack, forKey:"inputColor0")
cfilter!.setValue(ciBlue, forKey:"inputColor1")

var checkerboardImage = ctx.createCGImage(cfilter!.outputImage!, fromRect:sfilter!.outputImage!.extent)
filteredImage = UIImage(CGImage: checkerboardImage)
iv.image = filteredImage


var filter = CIFilter(name:"CIBlendWithMask")
filter!.setDefaults
filter!.setValue(CIImage(CGImage: checkerboardImage), forKey:"inputBackgroundImage")
filter!.setValue(CIImage(CGImage: sharpenedImage),    forKey:"inputMaskImage")

cgImage = ctx.createCGImage(filter!.outputImage!, fromRect:sfilter!.outputImage!.extent)
filteredImage = UIImage(CGImage: cgImage)
iv.image = filteredImage

//CPSetExecutionShouldContinueIndefinitely()
