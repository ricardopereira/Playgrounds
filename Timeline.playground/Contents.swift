//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

final class MyTableViewController : UITableViewController {

    var data = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        for n in 1...50 {
            data.append(n)
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = String(data[indexPath.row])

        return cell
    }

}

XCPlaygroundPage.currentPage.liveView = MyTableViewController()
