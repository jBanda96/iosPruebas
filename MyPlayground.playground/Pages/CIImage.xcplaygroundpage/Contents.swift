import UIKit
import PlaygroundSupport


func paddinZerosToLeft(upto: Int, into string: String) -> String {
    if upto <= string.count {
        return string
    }
    return String(repeatElement("0", count: upto - string.count)) + string
}


paddinZerosToLeft(upto: 3, into: "10")


class Test {
    let dateInMiliseconds: String
    let id: Int
    
    init(dateInMiliseconds: String, id: Int) {
        self.dateInMiliseconds = dateInMiliseconds
        self.id = id
    }
}

func getDate(for test: Test) -> DateComponents {
    let timeInterval = Double(test.dateInMiliseconds)!
    let dateSince1970 = Date.init(timeIntervalSince1970: timeInterval)
    
    let calendar = Calendar.current
    return calendar.dateComponents([.day, .month, .year], from: dateSince1970)
}

let a = Test(dateInMiliseconds: "1566055968", id: 1)
let b = Test(dateInMiliseconds: "1566055968", id: 2)
let c = Test(dateInMiliseconds: "1561055968", id: 3)

let tests = [a, b, c]
var grouped = [[Test]]()

func group(_ test: [Test]) {
    for test in tests {
        grouped.append([test])
    }
}

group(tests)

print("-----------")
for section in grouped {
    for row in section {
        print(row.id)
    }
    print("-")
}
print("-----------")


//func group(_ objects: [Test]) {
//    for object in objects {
//
//        if grouped.isEmpty {
//            grouped.append([object])
//            continue
//        }
//
//        for section in grouped {
//
//            if section.count == 3 {
//                break
//            }
//
//            for row in section {
//
//                let own = getDate(for: object)
//                let dif = getDate(for: row)
//
//                print("\(dif.day!) - \(own.day!)")
//                print("\(dif.month!) - \(own.month!)")
//                print("\(dif.year!) - \(own.year!)")
//
//                if dif.day == own.day && dif.month == own.month && dif.year == own.year {
//                    grouped[sectionAux].append(object)
//                } else {
//                    grouped.append([object])
//                }
//
//            }
//            sectionAux += 1
//        }
//
//    }
//}
