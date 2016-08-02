//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

final class NumberPadView: UIView, ViewGradients {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteColor()

        let newButton: (Int) -> UIButton = { number in
            let button = UIButton(type: .System)
            button.setTitle(String(number), forState: .Normal)
            button.tintColor = .whiteColor()
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
            button.tag = number
            return button
        }

        let firstRow = UIStackView(arrangedSubviews: [
            newButton(1),
            newButton(2),
            newButton(3)
            ]
        )
        firstRow.distribution = .FillEqually

        let secondRow = UIStackView(arrangedSubviews: [
            newButton(4),
            newButton(5),
            newButton(6)
            ]
        )
        secondRow.distribution = .FillEqually

        let thirdRow = UIStackView(arrangedSubviews: [
            newButton(7),
            newButton(8),
            newButton(9)
            ]
        )
        thirdRow.distribution = .FillEqually

        let fourthRow = UIStackView(arrangedSubviews: [
            newButton(0),
            newButton(0),
            newButton(0)
            ]
        )
        fourthRow.distribution = .FillEqually

        let mainStackView = UIStackView(arrangedSubviews: [
            firstRow,
            secondRow,
            thirdRow,
            fourthRow
            ]
        )
        mainStackView.frame = self.bounds
        addSubview(mainStackView)
        mainStackView.distribution = .FillEqually
        mainStackView.axis = .Vertical
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //mainStackView.frame = self.bounds
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawGradient(frame: rect)
    }

}

protocol ViewGradients {
    func drawGradient(frame frame: CGRect, gradient2Color: UIColor, gradient2Color2: UIColor)
}

extension ViewGradients {

    func drawGradient(frame frame: CGRect = CGRect(x: 29, y: 28, width: 136, height: 77), gradient2Color: UIColor = UIColor(red: 0.498, green: 0.271, blue: 0.878, alpha: 1.000), gradient2Color2: UIColor = UIColor(red: 0.543, green: 0.364, blue: 0.843, alpha: 1.000)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Gradient Declarations
        let gradient2 = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [gradient2Color2.CGColor, gradient2Color.CGColor], [0, 1])!

        //// Rectangle Drawing
        let rectangleRect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height)
        let rectanglePath = UIBezierPath(rect: rectangleRect)
        CGContextSaveGState(context)
        rectanglePath.addClip()
        CGContextDrawLinearGradient(context, gradient2,
                                    CGPoint(x: rectangleRect.midX, y: rectangleRect.minY),
                                    CGPoint(x: rectangleRect.midX, y: rectangleRect.maxY),
                                    CGGradientDrawingOptions())
        CGContextRestoreGState(context)
    }

}

final class DemoViewController : UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let numberPadView = NumberPadView()

        numberPadView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(numberPadView)
        NSLayoutConstraint.activateConstraints([
            numberPadView.topAnchor.constraintEqualToAnchor(self.view.topAnchor, constant: 60),
            numberPadView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor, constant: 20),
            numberPadView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor, constant: -20),
            numberPadView.heightAnchor.constraintEqualToConstant(340),
        ])

        numberPadView.layer.cornerRadius = 10.0
        numberPadView.layer.masksToBounds = true
    }

}

XCPlaygroundPage.currentPage.liveView = DemoViewController()
