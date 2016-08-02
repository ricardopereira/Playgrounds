//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

final class MyTableViewController : UITableViewController {

    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        (1...50).forEach { _ in
            data.append(NSProcessInfo.processInfo().globallyUniqueString)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = data[indexPath.row]

        return cell
    }
}

XCPlaygroundPage.currentPage.liveView = MyTableViewController()
