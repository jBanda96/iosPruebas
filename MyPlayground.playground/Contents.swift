//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=CErrxmo4ZWgSY0wH8AbSiRp37EvKXSx82qw7Q6PQ")!

let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let data = data {
        let _ = String(data: data, encoding: .utf8)
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
    let _ = bill.reduce(0) { (result, int) -> Int in
        cont += 1
        if cont != k {
            return result + int
        } else {
            return result
        }
    }
    
    let billDivided = 1
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


let pages: Int = 5
let pageToGo: Int = 4
func pageCount(n: Int, p: Int) -> Int {
    var turns: Int = 0
    
    if (n / 2) >= p {
        "Desde el inicio"
        
        for page in 1...p {
            turns = page / 2
        }
        
    } else {
        "Desde el final"
        
        if n == p && p.remainderReportingOverflow(dividingBy: 2).partialValue == 0 {
            return 0
        } else {
            turns += 1
        }
        
        for page in (1...n).reversed(){
            
            if page.remainderReportingOverflow(dividingBy: 2).partialValue == 0 {
                    turns += 1
            }
            
            if page == p {
                return turns
            }
        }
    }
    
    return turns
}

print(pageCount(n: pages, p: pageToGo))

func countingValleys(n: Int, s: String) -> Int {
    
    print("---------------- countingValleys ----------------")
    let seaLevel = 0
    var currentStep = 0
    
    var numberOfValleys = 0
    var countValleys = true
    
    for string in s {
        if string == "D" {
            currentStep -= 1
            
            if currentStep < seaLevel && countValleys {
                numberOfValleys += 1
                countValleys = false
            }
            
        } else if string == "U" {
            currentStep += 1
            
            if currentStep >= 0 {
                countValleys = true
            }
        }
    }
    
    print("Number of valleys: \(numberOfValleys)\n\n")
    return numberOfValleys
}

let s = "DUDUUUDUUUDDUDDUDUUDUDDUDDDUUUUUUDUDUDUDDUDDDUUUUUUDDUDUUUUUDUDU"
let number = s.count
countingValleys(n: number, s: s)

func getMoneySpent(keyboards: [Int], drives: [Int], b: Int) -> Int {
    print("---------------- Electronic shop ----------------\n\n")
    
    var total = -1
    
    for keyboard in keyboards {
        for drive in drives {
            
            let posibleAmount = keyboard + drive
            
            if posibleAmount <= b {
                if posibleAmount > total {
                    total = posibleAmount
                }
            }
            
        }
    }
    
    return total
}

let keyboards = [1]
let drives = [4]
let amount = 5
getMoneySpent(keyboards: keyboards, drives: drives, b: amount)


func catAndMouse(x: Int, y: Int, z: Int) -> String {
    print("---------------- Cats and Mouse ----------------")
    var answer = "Mouse C"
    
    let catA = retrieveNumberOfStepsFromCat(x, toMouse: z)
    let catB = retrieveNumberOfStepsFromCat(y, toMouse: z)
    
    if catA < catB {
        answer = "Cat A"
    } else if catB < catA {
        answer = "Cat B"
    }
    
    print(answer)
    return answer
}

func retrieveNumberOfStepsFromCat(_ cat: Int, toMouse mouse: Int) -> Int {
    var steps = 0
    
    if cat <= mouse {
        
        for _ in cat...mouse {
            steps += 1
        }
        
    } else if mouse < cat {
        for _ in (mouse...cat) {
            steps += 1
        }
    }
    
    return steps
}

let catA = 3
let catB = 5
let mouse = 4

catAndMouse(x: catA, y: catB, z: mouse)


func pickingNumbers(a: [Int]) -> Int {
    
    var maximumLength = 0
    
    print("\n\n---------------- Picking Numbers ----------------")
    for (index, number) in a.enumerated() {
        if index < a.count {
            print(number - a[index])
            if number - a[index] <= 1 {
                maximumLength += 1
            }
        }
        
    }
    
    return maximumLength
}


let numbers = [4, 6, 5, 3, 3, 1]
pickingNumbers(a: numbers)

print("\n\n---------------- Left Rotation NO TERMINADO ----------------")
let numberOfNumbers = 5
let rotations = 4
let rotationArray = [1, 2, 3, 4, 5]

let mod = rotations % numberOfNumbers
    for rotation in 1...rotations {
    }
print(mod)

print("\n\n---------------- Is Balanced ----------------")
let brackets = "[]{}"
var x = (brackets.count / 2) - 1
var isBalanced = false
if brackets.count == 0 || brackets.count.quotientAndRemainder(dividingBy: 2).remainder != 0 {
    
} else {
    for _ in 1...(brackets.count / 2) {
    
    let start = brackets.index(brackets.startIndex, offsetBy: x)
    let end = brackets.index(brackets.endIndex, offsetBy: -x)
    let range = start..<end
    let substring = String(brackets[range])

    let substringEnd = substring.index(substring.endIndex, offsetBy: -1)
    let first = String(substring[substring.startIndex])
    let last = String(substring[substringEnd])
    
    print("\(first) - \(last)")
    
    let oposite: String
    switch first {
    case "(":
        oposite = ")"
    case "{":
        oposite = "}"
    case "[":
        oposite = "]"
    default:
        oposite = ""
    }
    
    if last == oposite {
        isBalanced = true
    } else {
        isBalanced = false
        break
    }
    
    x -= 1
    
}
}
print("\(isBalanced ? "YES" : "NO")")

print("\n\n---------------- Candies ----------------")
let candieArr = [1, 2, 2]
let candieN = 3
func candies(n: Int, arr: [Int]) -> Int {
    var totalCandies = 0
    
    for (index, children) in arr.enumerated() {
        
        let indexToCompare = index + 1
        print(indexToCompare)
        
    }
    
    return totalCandies
}
candies(n: candieN, arr: candieArr)

let aaa: String = "jjjjjjjjjjjjjjjjjjj"
let bbb: String = "kkkkkkkkkkkkkkkkkkk"
func mergeString(a: String, b: String) -> String {
    print("\n\n---------------- Merge String ----------------")
    var mergedString = ""
    
    let arrayA      =       Array(aaa)
    let arrayB      =       Array(bbb)
    
    let index       =       arrayA.count >= arrayB.count    ?   arrayA.count   :      arrayB.count
    
    for index in 0 ..< index {
        
        if index < arrayA.count {
            mergedString += String(arrayA[index])
        }
        
        if index < arrayB.count {
            mergedString += String(arrayB[index])
        }
        
    }
    
    return mergedString
}
mergeString(a: aaa, b: bbb)

let countMaxArray: [String]         =       ["6 5", "6 5","5 5", "3 2", "2 1", "5 2"]
func countMax(upRight: [String]) -> Int {
    print("\n\n---------------- Count Max ----------------")
    let convertedArray: [[Int]] = upRight.reduce([]) { (result, string) -> [[Int]] in
        let split = string.split(separator: " ")
        return result + [[Int(String(split[0]))!, Int(String(split[1]))!]]
    }
    
    var lowerRow:       Int     =       convertedArray[0][0]
    var lowerColumn:    Int     =       convertedArray[0][1]
    
    convertedArray.forEach {
        if lowerRow > $0[0] {
            lowerRow    =       $0[0]
        }
        
        if lowerColumn > $0[1] {
            lowerColumn     =       $0[1]
        }
    }
    
    print("   Lower Row: \(    lowerRow    )")
    print("Lower Column: \(    lowerColumn )")
    
    return lowerRow * lowerColumn
}
countMax(upRight: countMaxArray)


let palindrome:     String  =   "bab"
func breakPalindrome(s: String) -> String {
    print("\n\n---------------- Breaking a Palindrome ----------------")
    var characters:     [Character]     =       Array(s)
    let replacement:    [Character]     =       Array("abcdefghijklmnopqrstuvwxyz")
    
    for (index, _) in characters.enumerated() {
        
        characters = Array(s)
        for (_, replace) in replacement.enumerated() {
            
            characters[index] = replace
            
            let newString:   String     =       characters.reduce("") { $0 + String($1) }
            print("\(newString)")
            
            if (newString != String(newString.reversed())) && (newString.lexicographicallyPrecedes(s)) {
                print("No es un palindromo y es menor lexicograficamente")
                return newString
            }
            
            print("---------------------------")
        }
    }
    
    return "IMPOSSIBLE"
}
breakPalindrome(s: palindrome)


func canCreateTriangle(a: Int, b: Int, c: Int) -> Bool {
    
    print("\n\n---------------- Can create a triangle ----------------")
    if (a + b > c) && (a + c > b) && (b + c > a){
        return true
    } else {
        return false
    }
    
}
print(canCreateTriangle(a: 3, b: 4, c: 5))

func hurdleRace(k: Int, height: [Int]) -> Int {
    print("\n\n---------------- Hurdle Race ----------------")
    return max(((height.max() ?? 0) - k), 0)
}
print(hurdleRace(k: 5, height: [1, 6, 3, 5, 2]))


func designerPdfViewer(h: [Int], word: String) -> Int {
    print("\n\n---------------- Designer PDF Viewer ----------------")
    let alphabet: [Character]   =   Array("abcdefghijklmnopqrstuvwxyz")
    
    var biggerHeight: Int   =   1
    for (index, a) in alphabet.enumerated() {
        for b in word {
            if a == b {
                biggerHeight =  h[index] > biggerHeight     ?       h[index] : biggerHeight
            }
        }
    }
    
    print(biggerHeight * word.count)
    return biggerHeight * word.count
}

designerPdfViewer(h: [1, 3, 1, 3, 1, 4, 1, 3, 2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 7], word: "abc")



func sumFromOne(upTo n: Int) -> Int {
    //return (0...upTo).reduce(0, +)
    return (n + 1) * n / 2
}
sumFromOne(upTo: 3)

public class Node<Value>: CustomStringConvertible {
    public var value:   Value
    public var next:    Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
    public var description: String {
        guard let next = next else {
            return "\(self.value)"
        }
        return "\(self.value) -> \(String(describing: next))"
    }
}

print("\n\n---------------- Nodos ----------------")
let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(node1)



public struct LinkedList<Value>: CustomStringConvertible {
    
    public var head: Node <Value>?
    public var tail: Node <Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var description: String {
        guard let head = head else { return "Empty List" }
        return String(describing: head)
    }
    
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode     =   head
        var currentIndex    =   0
        
        while currentNode != nil && currentIndex < index {
            currentNode     =   currentNode!.next
            currentIndex    +=  1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail != nil else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        guard let head = head else { return nil }
        guard head.next != nil else { return pop() }
        
        var prev    =   head
        var current =   head
        
        while let next = current.next {
            prev    =   current
            current =   next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
    }
    
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
    
}

print("\n\n---------------- Linked List ----------------")
var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)

//list.append(1)
//list.append(2)
//list.append(3)

print("Before inserting: \(list)")
var middleNode = list.node(at: 1)
list.insert(4, after: middleNode!)
print("After inserting: \(list)")

print("Before poping\(list)")
list.pop()
print("After poping\(list)")

print("After removing last: \(list)")
list.removeLast()
print("Before removing last: \(list)")


print("After removing at: \(list)")
let node = list.node(at: 0)!
list.remove(after: node)
print("Before removing at: \(list)")

