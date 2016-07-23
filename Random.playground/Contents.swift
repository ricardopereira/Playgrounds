//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let array = [12,3,1,4,1,2,3,5]

let zipped = zip(array, 0..<array.count)
let smallerNumber = zipped.sort { $0.0 < $1.0}.first.map { $0.0 }

smallerNumber

let minIndex = zip(array, array.indices).minElement{ $0.0 < $1.0 }.map { $0.1 }

array[minIndex!]


// Dictionaries union

let moreAttributes: [String:AnyObject] = ["Function":"authenticate"]
let attributes: [String:AnyObject] = ["File":"Auth.swift"]

func + <K,V> (left: Dictionary<K,V>, right: Dictionary<K,V>?) -> Dictionary<K,V> {
    guard let right = right else { return left }
    return left.reduce(right) {
        var new = $0 as [K:V]
        new.updateValue($1.1, forKey: $1.0)
        return new
    }
}

attributes + moreAttributes + nil
attributes + moreAttributes
attributes + nil

func += <K,V> (inout left: Dictionary<K,V>, right: Dictionary<K,V>?) {
    guard let right = right else { return }
    right.forEach { key, value in
        left.updateValue(value, forKey: key)
    }
}

let b: [String:AnyObject] = ["Function":"authenticate"]
var a: [String:AnyObject] = ["File":"Auth.swift"]

a += nil
a += b


enum DialogFilterOptions {
    case Today
    case Yesterday
    case LastWeek
    case LastMonth
    case Custom

    var toString: String {
        switch self {
        case .Today: return "Hoje"
        case .Yesterday: return "Yesterday"
        case .LastWeek: return "Week"
        case .LastMonth: return "Month"
        case .Custom: return "Custom"
        }
    }
}

extension DialogFilterOptions: CustomStringConvertible {
    var description: String {
        switch self {
        case .Today: return "Today"
        case .Yesterday: return "Yesterday"
        case .LastWeek: return "LastWeek"
        case .LastMonth: return "LastMonth"
        case .Custom: return "Custom"
        }
    }
}

extension DialogFilterOptions: RawRepresentable {
    init?(rawValue: Int) {
        switch rawValue {
        case 1:
            self = .Today
        case 2:
            self = .Yesterday
        case 3:
            self = .LastWeek
        case 4:
            self = .LastMonth
        case 0:
            self = .Custom
        default:
            return nil
        }
    }

    var rawValue: Int {
        switch self {
        case .Today: return 1
        case .Yesterday: return 2
        case .LastWeek: return 3
        case .LastMonth: return 4
        case .Custom: return 0
        }
    }
}

DialogFilterOptions(rawValue: 1)?.rawValue
DialogFilterOptions(rawValue: 0)
DialogFilterOptions(rawValue: 123)
String(DialogFilterOptions.Today)

let oldSchemaVersion = 1

switch oldSchemaVersion {
case 1 ..< 2:
    print("Do 1")
    fallthrough
case 2 ..< 3:
    print("Do 2")
    fallthrough
default:
    break
}


func pow2(radix: Int, _ power: Int) -> Double {
    return pow(Double(radix), Double(power))
}

var decimals = 2
var fraction = true
let digits: [Int] = [6,7,9]
let d = digits.map { Double($0) }
var number = 0.0

for var i = d.count-1, x = 0; i>=0; i-- {
    if fraction {
        number += d[i] * 1.0 / pow2(10, decimals - x++)
    }
    else {
        number += d[i] * 1.0 * pow2(10, decimals - x--)
    }

    if decimals - x == 0 {
        fraction = false
    }
}

number

fraction = false
number = 0.0

for (index, value) in (digits.map{ Double($0) }).enumerate() {
    let reversedIndex = digits.count - index
    if fraction {
        number += value * 1.0 / pow2(10, reversedIndex - 1 + decimals)
    }
    else {
        number += value * 1.0 * pow2(10, reversedIndex - 1 - decimals)
    }

    if reversedIndex - decimals == 0 {
        fraction = true
    }
}

number


class Item {
    var name: String = ""
    init(name: String) {
        self.name = name
    }
}

class Collection {
    var dictionary = NSMutableDictionary()
    func add(name: String) -> Item {
        dictionary[name] = Item(name: name)
        return dictionary[name] as! Item
    }
    func release(item: Item) {
        dictionary.removeObjectForKey(item.name)
    }
}

let items = Collection()
weak var item1: Item! = items.add("asjflkajsdf")

print(item1.name)
items.release(item1)
print(item1.name)





