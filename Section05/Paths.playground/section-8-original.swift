        var outlinePath = UIBezierPath(arcCenter: center,
            radius: radius/2 - 2.5,
            startAngle: startAngle,
            endAngle: outlineEndAngle,
            clockwise: true)

        outlinePath.addArcWithCenter(center,
            radius: radius/2 - arcWidth + 2.5,
            startAngle: outlineEndAngle,
            endAngle: startAngle,
            clockwise: false)
        
        outlinePath.closePath()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
    }
}
