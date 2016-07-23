//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class MarkView: UIView {

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawCanvas1()
    }

    func drawCanvas1(frame frame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)) {
        //// Color Declarations
        let color = UIColor(red: 0.118, green: 0.718, blue: 1.000, alpha: 1.000)

        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalInRect: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height))
        color.setFill()
        ovalPath.fill()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: frame.minX + 0.23000 * frame.width, y: frame.minY + 0.47000 * frame.height))
        bezierPath.addCurveToPoint(CGPoint(x: frame.minX + 0.41000 * frame.width, y: frame.minY + 0.65000 * frame.height), controlPoint1: CGPoint(x: frame.minX + 0.57000 * frame.width, y: frame.minY + 0.81000 * frame.height), controlPoint2: CGPoint(x: frame.minX + 0.41000 * frame.width, y: frame.minY + 0.65000 * frame.height))
        bezierPath.addLineToPoint(CGPoint(x: frame.minX + 0.75000 * frame.width, y: frame.minY + 0.31000 * frame.height))
        color.setFill()
        bezierPath.fill()
        UIColor.whiteColor().setStroke()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
    }

}

let markView = MarkView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
UIView.animateWithDuration(2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.1, options: .CurveEaseIn, animations: {
    markView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    markView.layer.position = CGPointMake(0, 0)
}, completion: nil)

XCPlaygroundPage.currentPage.liveView = markView
