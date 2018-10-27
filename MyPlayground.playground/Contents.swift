//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=CErrxmo4ZWgSY0wH8AbSiRp37EvKXSx82qw7Q6PQ")!

let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data {
        let string = String(data: data, encoding: .utf8)
        print(string!)
    }
}

task.resume()

let queries = ["api_key":"CErrxmo4ZWgSY0wH8AbSiRp37EvKXSx82qw7Q6PQ"]
queries.compactMap({ (key, value) -> URLQueryItem in
    return URLQueryItem(name: key, value: value)
})

let array = [1, 2, 3, 4, 5]
for _ in array {
    //print(num)
}


func staircase(n: Int) -> Void {
    
    for space in (0..<n).reversed() {
        let spaces = String.init(repeating: " ", count: space)
        let pads = String.init(repeating: "#", count: n - space)
        
        let completeLine = spaces + pads
        print(completeLine)
    }
    
}
staircase(n: 4)

func miniMaxSum(arr: [Int]) -> Void {
    
    var min = arr[0]
    var max = arr[0]
    
    var total: Int = 0
    
    for num in arr {
        if min > num {
            min = num
        }
        
        if max < num {
            max = num
        }
        
        total += num
        
    }
    
    print("\(total - max) \(total - min)")
}


let bill = [3, 10, 2, 9]
let k = 1
let b = 7

func bonAppetit(bill: [Int], k: Int, b: Int) -> Void {
    
    var cont = -1
    let totalBill = bill.reduce(0) { (result, int) -> Int in
        cont += 1
        if cont != k {
            return result + int
        } else {
            return result
        }
    }
    
    let billDivided = totalBill.unsafeDivided(by: 2)
    let amount = b - billDivided
    
    if amount == 0 {
        print("Bon Appetit")
    } else {
        print("\(amount)")
    }
    
}

bonAppetit(bill: bill, k: 1, b: 12)

let array1 = [10, 20, 20, 10, 10, 30, 50, 10, 20]
let n = array1.count
func sockMerchant(n: Int, ar: [Int]) -> Int {
    
    var dictionary = Dictionary<String, Int>()
    var totalPairs = 0
    
    for socket in ar {
        
        if dictionary.keys.count == 0 {
            dictionary["\(socket)"] = 1
        } else {
            
            for object in dictionary {
                if Int(object.key) == socket {
                    let value = object.value + 1
                    dictionary["\(socket)"] = value
                    break
                } else {
                    dictionary["\(socket)"] = 1
                }
            }
            
        }
        
    }
    
    dictionary
    
    for socket in dictionary.values {
        
        let (entero, _) = socket.quotientAndRemainder(dividingBy: 2)
        totalPairs += entero
        
    }
    
    return totalPairs
}

sockMerchant(n: n, ar: array1)


let factorial = 25
func extraLongFactorials(n: Int) -> Void {
    
    var fac: Double = 1
    for num in (1...n).reversed() {
        fac = fac * Double(num)
    }
    
    
    
}

extraLongFactorials(n: factorial)

func carryAll(_ arr: [Int]) -> [Int] {
    var result = [Int]()
    
    var carry = 0
    for val in arr.reversed() {
        let total = val + carry
        let digit = total % 10
        carry = total / 10
        result.append(digit)
    }
    
    while carry > 0 {
        let digit = carry % 10
        carry = carry / 10
        result.append(digit)
    }
    
    return result.reversed()
}



func factorial(_ n: Int) -> String {
    var result = [1]
    for i in 2...n {
        result = result.map { $0 * i }
        result = carryAll(result)
    }
    
    return result.map(String.init).joined()
}

factorial(25)
