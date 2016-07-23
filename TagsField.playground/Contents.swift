//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

class TagsViewController: UIViewController {

    let tagsField = TagsField()
    let log = UITextView()
    let testButton = UIButton(type: .System)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .redColor()
        tagsField.placeholder = "Enter a tag"
        tagsField.backgroundColor = .whiteColor()
        tagsField.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        view.addSubview(tagsField)

        // Events
        tagsField.onDidAddTag = { _ in
            self.log("DidAddTag")
        }

        tagsField.onDidRemoveTag = { _ in
            self.log("DidRemoveTag")
        }

        tagsField.onDidChangeText = { _, text in
            
        }

        tagsField.onDidBeginEditing = { _ in
            self.log("DidBeginEditing")
        }

        tagsField.onDidEndEditing = { _ in
            self.log("DidEndEditing")
        }

        tagsField.onDidChangeHeightTo = { sender, height in
            self.log("HeightTo \(height)")
        }

        testButton.frame = CGRect(x: 0, y: 250, width: 100, height: 44)
        testButton.backgroundColor = .whiteColor()
        testButton.setTitle("Test", forState: .Normal)
        view.addSubview(testButton)
        testButton.addTarget(self, action: #selector(didTouchTestButton), forControlEvents: .TouchUpInside)

        log.frame = CGRect(x: 0, y: 300, width: 350, height: 300)
        log.backgroundColor = .whiteColor()
        log.text = "Log"
        view.addSubview(log)
    }

    func didTouchTestButton(sender: AnyObject) {
        tagsField.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tagsField.spaceBetweenTags = 10.0
        tagsField.font = UIFont.systemFontOfSize(12.0)
        tagsField.tintColor = .greenColor()
        tagsField.textColor = .blackColor()
        tagsField.fieldTextColor = .blueColor()
        tagsField.selectedColor = .blackColor()
        tagsField.selectedTextColor = .redColor()
        tagsField.delimiter = ","
        print(tagsField.tags)
    }

    func log(text: String) {
        self.log.text = self.log.text! + ", " + text
    }

    override func viewDidAppear(animated: Bool) {
        if tagsField.isEditing == false {
            tagsField.beginEditing()
        }
        super.viewDidAppear(animated)
    }

}

XCPlaygroundPage.currentPage.liveView = TagsViewController()
