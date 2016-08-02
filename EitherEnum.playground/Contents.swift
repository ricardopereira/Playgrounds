//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

enum Either<A, B, C> {
    case Number(A)
    case Name(B)
    case Money(C)

    func title() -> String {
        switch self {
        case .Number(let number):
            return "Number : \(number)"
        case .Name(let name):
            return "Name : \(name)"
        case .Money(let money):
            return "money : \(money)"
        }
    }
}


final class MyTableViewController : UITableViewController {

    let data : [Either<Int,String,Double>] =
        [Either.Number(1),
         Either.Money(10.2),
         Either.Number(2),
         Either.Name("My name"),
         Either.Money(5.99),
         Either.Name("My name2")]

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = data[indexPath.row].title()

        return cell
    }
}

let tableViewController = MyTableViewController()
XCPlaygroundPage.currentPage.liveView = tableViewController
