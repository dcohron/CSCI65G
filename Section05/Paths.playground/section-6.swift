        let path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference:CGFloat = 2 * π - startAngle + endAngle
        let arcLengthPerSection = angleDifference / CGFloat(NoOfSections)
        let outlineEndAngle = arcLengthPerSection * CGFloat(counter) + startAngle
