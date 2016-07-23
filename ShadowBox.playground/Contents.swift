//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class StyleKit {

    class func drawBackground(frame frame: CGRect = CGRectMake(0, 0, 240, 120)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let color1 = UIColor(red: 0.302, green: 0.290, blue: 0.949, alpha: 1.000)
        let color2 = UIColor(red: 0.580, green: 0.537, blue: 0.961, alpha: 1.000)

        //// Gradient Declarations
        let gradient1 = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [color1.CGColor, color2.CGColor], [0, 1])!

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(frame.minX, frame.minY, frame.width, frame.height))
        CGContextSaveGState(context)
        rectanglePath.addClip()
        let rectangleRotatedPath = UIBezierPath()
        rectangleRotatedPath.appendPath(rectanglePath)
        var rectangleTransform = CGAffineTransformMakeRotation(45*(-CGFloat(M_PI)/180))
        rectangleRotatedPath.applyTransform(rectangleTransform)
        let rectangleBounds = CGPathGetPathBoundingBox(rectangleRotatedPath.CGPath)
        rectangleTransform = CGAffineTransformInvert(rectangleTransform)

        CGContextDrawLinearGradient(context, gradient1,
            CGPointApplyAffineTransform(CGPointMake(rectangleBounds.minX, rectangleBounds.midY), rectangleTransform),
            CGPointApplyAffineTransform(CGPointMake(rectangleBounds.maxX, rectangleBounds.midY), rectangleTransform),
            CGGradientDrawingOptions())
        CGContextRestoreGState(context)
    }

}

class ShadowBox<T: UIView>: UIView {

    let view: T

    convenience init() {
        self.init(view: T.init())
    }

    init(view: T) {
        self.view = view
        super.init(frame: view.frame)
        insertSubview(view, atIndex: 0)

        layer.cornerRadius = view.layer.cornerRadius
        layer.shadowColor = UIColor.darkGrayColor().CGColor
        layer.shadowOffset = CGSize(width: 0.0, height: 30.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20.0
        layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).CGPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.mainScreen().scale
    }

    class func createWith(view: T) -> ShadowBox {
        return ShadowBox(view: view)
    }

    override var center: CGPoint {
        didSet {
            view.center = CGPointMake(view.bounds.width/2.0, view.bounds.height/2.0)
        }
    }

}

class DialogView: UIView {

    var shadowLayer = CAShapeLayer()

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        StyleKit.drawBackground(frame: self.bounds)
    }

}

class Button: UIButton {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        print("Began")
        UIView.animateWithDuration(0.2) { 
            self.viewForFirstBaselineLayout.alpha = 0
        }
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //touchesEnded not getting called when combined with UIButton because of TapGesture!!
        super.touchesEnded(touches, withEvent: event)
        print("Ended")
        UIView.animateWithDuration(0.2) {
            self.viewForFirstBaselineLayout.alpha = 1
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        print("Moved")
        UIView.animateWithDuration(0.2) {
            self.viewForFirstBaselineLayout.alpha = 1
        }
    }

}

class ButtonDelegateTest: NSObject {

    func didTouch(sender: UIButton) {
        print("Click!")
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://echo.ably.io/?type=asd&body={}")!) { data, response, error in
            print(data)
            print(response)
            print(error)
        }.resume()
    }

    func handleTap(sender: UITapGestureRecognizer) {
        // Overrides the didTouch!
        print("Tap")
        guard let button = sender.view as? UIButton else { return }
        UIView.animateWithDuration(0.2) {
            button.viewForFirstBaselineLayout.alpha = 1
        }
    }

}

let buttonDelegate = ButtonDelegateTest()

let mainView = UIView()
mainView.backgroundColor = UIColor.whiteColor()
mainView.frame = CGRectMake(0, 0, 320, 640)

let dialogView = DialogView()
dialogView.frame = CGRectMake(0, 0, 250, 100)
dialogView.center = mainView.center
dialogView.layer.cornerRadius = 14.0
dialogView.layer.masksToBounds = true
//dialogView.clipsToBounds = true

let dialogWithShadow = ShadowBox.createWith(dialogView)
dialogWithShadow.center = mainView.center

let button = Button()
button.setTitle("Click me", forState: .Normal)
button.frame = CGRectMake(0, 0, 100, 50)
button.backgroundColor = .redColor()
button.layer.cornerRadius = 14.0

button.addTarget(buttonDelegate, action: #selector(ButtonDelegateTest.didTouch(_:)), forControlEvents: [.TouchUpInside, .TouchUpOutside])

//button.addGestureRecognizer(UITapGestureRecognizer(target: buttonDelegate, action: #selector(ButtonDelegateTest.handleTap(_:))))

let buttonWithShadow = ShadowBox.createWith(button)
buttonWithShadow.center = CGPointMake(mainView.center.x, mainView.center.y - 150.0)

mainView.addSubview(buttonWithShadow)

XCPlaygroundPage.currentPage.liveView = mainView
