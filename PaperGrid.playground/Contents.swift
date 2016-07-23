//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class PaperView: UIView {

    let label = UILabel()

    init(text: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 72, height: 50))
        label.text = text
        label.textAlignment = .Left
        backgroundColor = .redColor()
        addSubview(label)
        print(label.text, " Frame: ", frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.font = label.font?.fontWithSize(10.0)
        label.textColor = UIColor(red: 0.668, green: 0.700, blue: 0.714, alpha: 1.000)
        label.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawCanvasPaper(frame: rect)
        print(label.text, " Rect: ", rect)
    }

    func drawCanvasPaper(frame frame: CGRect = CGRect(x: 0, y: 0, width: 72, height: 50)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let strokeColor = UIColor(red: 0.668, green: 0.700, blue: 0.714, alpha: 1.000)


        //// Subframes
        let paperDraw: CGRect = CGRect(x: frame.minX, y: frame.minY, width: frame.width + 0.02, height: frame.height - 0.02)


        //// Paper Draw
        //// Paper Frame
        CGContextSaveGState(context)
        CGContextBeginTransparencyLayer(context, nil)

        //// Clip Clip
        let clipPath = UIBezierPath()
        clipPath.moveToPoint(CGPoint(x: paperDraw.minX + 0.00000 * paperDraw.width, y: paperDraw.minY + 0.00000 * paperDraw.height))
        clipPath.addLineToPoint(CGPoint(x: paperDraw.minX + 1.00000 * paperDraw.width, y: paperDraw.minY + 0.00000 * paperDraw.height))
        clipPath.addLineToPoint(CGPoint(x: paperDraw.minX + 1.00000 * paperDraw.width, y: paperDraw.minY + 0.77191 * paperDraw.height))
        clipPath.addCurveToPoint(CGPoint(x: paperDraw.minX + 0.85158 * paperDraw.width, y: paperDraw.minY + 0.79167 * paperDraw.height), controlPoint1: CGPoint(x: paperDraw.minX + 1.00000 * paperDraw.width, y: paperDraw.minY + 0.84794 * paperDraw.height), controlPoint2: CGPoint(x: paperDraw.minX + 0.85158 * paperDraw.width, y: paperDraw.minY + 0.79167 * paperDraw.height))
        clipPath.addCurveToPoint(CGPoint(x: paperDraw.minX + 0.77839 * paperDraw.width, y: paperDraw.minY + 1.00000 * paperDraw.height), controlPoint1: CGPoint(x: paperDraw.minX + 0.85158 * paperDraw.width, y: paperDraw.minY + 0.79167 * paperDraw.height), controlPoint2: CGPoint(x: paperDraw.minX + 0.85226 * paperDraw.width, y: paperDraw.minY + 1.00000 * paperDraw.height))
        clipPath.addLineToPoint(CGPoint(x: paperDraw.minX + 0.00000 * paperDraw.width, y: paperDraw.minY + 1.00000 * paperDraw.height))
        clipPath.addLineToPoint(CGPoint(x: paperDraw.minX + 0.00000 * paperDraw.width, y: paperDraw.minY + 0.00000 * paperDraw.height))
        clipPath.closePath()
        clipPath.usesEvenOddFillRule = true;

        clipPath.addClip()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: paperDraw.minX + 0.00000 * paperDraw.width, y: paperDraw.minY + 0.00000 * paperDraw.height))
        bezierPath.addLineToPoint(CGPoint(x: paperDraw.minX + 1.00000 * paperDraw.width, y: paperDraw.minY + 0.00000 * paperDraw.height))
        bezierPath.addLineToPoint(CGPoint(x: paperDraw.minX + 1.00000 * paperDraw.width, y: paperDraw.minY + 0.77191 * paperDraw.height))
        bezierPath.addCurveToPoint(CGPoint(x: paperDraw.minX + 0.85158 * paperDraw.width, y: paperDraw.minY + 0.79167 * paperDraw.height), controlPoint1: CGPoint(x: paperDraw.minX + 1.00000 * paperDraw.width, y: paperDraw.minY + 0.84794 * paperDraw.height), controlPoint2: CGPoint(x: paperDraw.minX + 0.85158 * paperDraw.width, y: paperDraw.minY + 0.79167 * paperDraw.height))
        bezierPath.addCurveToPoint(CGPoint(x: paperDraw.minX + 0.77839 * paperDraw.width, y: paperDraw.minY + 1.00000 * paperDraw.height), controlPoint1: CGPoint(x: paperDraw.minX + 0.85158 * paperDraw.width, y: paperDraw.minY + 0.79167 * paperDraw.height), controlPoint2: CGPoint(x: paperDraw.minX + 0.85226 * paperDraw.width, y: paperDraw.minY + 1.00000 * paperDraw.height))
        bezierPath.addLineToPoint(CGPoint(x: paperDraw.minX + 0.00000 * paperDraw.width, y: paperDraw.minY + 1.00000 * paperDraw.height))
        bezierPath.addLineToPoint(CGPoint(x: paperDraw.minX + 0.00000 * paperDraw.width, y: paperDraw.minY + 0.00000 * paperDraw.height))
        bezierPath.closePath()
        strokeColor.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()


        CGContextEndTransparencyLayer(context)
        CGContextRestoreGState(context)


        //// Paper Line Drawing
        let paperLinePath = UIBezierPath()
        paperLinePath.moveToPoint(CGPoint(x: paperDraw.minX + 0.98290 * paperDraw.width, y: paperDraw.minY + 0.79465 * paperDraw.height))
        paperLinePath.addCurveToPoint(CGPoint(x: paperDraw.minX + 0.94398 * paperDraw.width, y: paperDraw.minY + 0.84387 * paperDraw.height), controlPoint1: CGPoint(x: paperDraw.minX + 0.98290 * paperDraw.width, y: paperDraw.minY + 0.79465 * paperDraw.height), controlPoint2: CGPoint(x: paperDraw.minX + 0.94942 * paperDraw.width, y: paperDraw.minY + 0.83838 * paperDraw.height))
        paperLinePath.addCurveToPoint(CGPoint(x: paperDraw.minX + 0.81131 * paperDraw.width, y: paperDraw.minY + 0.97000 * paperDraw.height), controlPoint1: CGPoint(x: paperDraw.minX + 0.89648 * paperDraw.width, y: paperDraw.minY + 0.89190 * paperDraw.height), controlPoint2: CGPoint(x: paperDraw.minX + 0.81131 * paperDraw.width, y: paperDraw.minY + 0.97000 * paperDraw.height))
        strokeColor.setStroke()
        paperLinePath.lineWidth = 2
        paperLinePath.stroke()
    }
    
}

let paper1 = PaperView(text: "001")
let paper2 = PaperView(text: "002")
let paper3 = PaperView(text: "003")
let paper4 = PaperView(text: "004")

let stackView = UIStackView()
stackView.axis = .Vertical
stackView.distribution = .FillEqually
stackView.alignment = .Fill
//stackView.spacing = 15

let row1View = UIStackView()
row1View.axis = .Horizontal
row1View.distribution = .FillProportionally
row1View.alignment = .Fill
//row1View.spacing = 30
row1View.addArrangedSubview(paper1)
row1View.addArrangedSubview(paper2)
stackView.addArrangedSubview(row1View)

let row2View = UIStackView()
row2View.axis = .Horizontal
row2View.distribution = .EqualCentering
row2View.alignment = .Center
//row2View.spacing = 30
row2View.addArrangedSubview(paper3)
row2View.addArrangedSubview(paper4)
stackView.addArrangedSubview(row2View)

stackView.frame = CGRect(x: 0, y: 0, width: 300, height: 150)

let mainView: UIView = {
    $0.backgroundColor = .redColor()
    $0.frame = CGRect(x: 10, y: 10, width: 300, height: 150)
    return $0
}(UIView())

XCPlaygroundPage.currentPage.liveView = mainView

