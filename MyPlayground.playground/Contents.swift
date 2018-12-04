//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//: ### Calling the NASA API
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
    let total = arr.reduce(0, +)
    print("\(total - arr.max()!) - \(total - arr.min()!)")
}
miniMaxSum(arr: [1, 2])

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

let startCountMax = Date()
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
let endCountMax = Date()
endCountMax.timeIntervalSince(startCountMax)


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

print("\n\n---------------- Stack ----------------")
struct Stack2<Element>: CustomStringConvertible {
    
    private var items = [Element]()
    
    public mutating func push(_ item: Element){
        items.append(item)
    }
    
    public mutating func pop() -> Element {
        return items.removeLast()
    }
    
    var description: String {
        guard !items.isEmpty else {
            return "Empty stack"
        }
        
        return String(describing: items)
    }
    
}

extension Stack2 {
    var topItem: Element? {
        return items.isEmpty ? nil : items.last
    }
}

var stack2 = Stack2<Int>()
stack2.push(1)
stack2.push(2)
stack2.push(3)
stack2.push(4)
print("Popped: \(stack2.pop())")
stack2
print("Top item: \(String(describing: stack2.topItem ?? 0))")

print("\n\n---------------- Nodos ----------------")
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

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(node1)

print("\n\n---------------- Linked List ----------------")
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

print("\n\n---------------- Stack ----------------")
struct Stack<Element>: CustomStringConvertible {
    
    private var storage: [Element] = []
    
    public init(_ elements: [Element]){
        storage = elements
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    public func peek() -> Element? {
        return storage.last
    }
    
    public func isEmpty() -> Bool {
        return peek() == nil
    }
    
    var description: String {
        
        let topDivider:     String  =   "----top---- "
        let bottomDivider:  String  =   "--------"
        
        let stackElements = storage.map { "\($0)" }.reversed().joined(separator: " ")
        
        return topDivider + stackElements + bottomDivider
        
    }
    
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

var stack: Stack = [1, 2]
stack.push(3)
stack.push(4)
stack.push(3)
stack.push(1)
print(stack)

public protocol Queue {
    associatedtype Element
    
    mutating func enqueue (_ element: Element)  -> Bool
    mutating func dequeue ()                    -> Element?
    
    var isEmpty:    Bool        { get }
    var peek:       Element?    { get }
}

public struct QueueArray<T>: Queue, CustomStringConvertible, ExpressibleByArrayLiteral {
    
    public typealias Element = T
    
    private var array: [T] = []
    
    public var description: String {
        return String(describing: array)
    }
    
    public init(arrayLiteral elements: Element...) {
        array = elements
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : array.removeFirst()
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var peek: T? {
        return array.first
    }
}

var a: QueueArray = [1, 2]
a.peek
a.enqueue(3)
a
a.dequeue()


let startSort = Date()
var bubble          =   [5, 4, 3, 2, 1]
let orderedBubble   =   bubble.sorted(by: <)
let endSort = Date()
endSort.timeIntervalSince(startSort)

let startBubble = Date()
let length = bubble.count

for i in 0 ..< length {
    for j in 0 ..< (length - i - 1) {
        if bubble[j] > bubble[j + 1] {
            let aux = bubble[j]
            bubble[j] = bubble[j + 1]
            bubble[j + 1] = aux
        }
    }
}
print(bubble)
let endBubble = Date()
endBubble.timeIntervalSince(startBubble)

func isBalanced(s: String) -> String {
    print("\n\n---------------- Balanced Brackets ----------------")
    
    let brackets: [Character]   =   Array(s)
    var isBalanced: Bool        =   true
    var stack                   =   Stack<Character>()
    
    if s.count.quotientAndRemainder(dividingBy: 2).remainder != 0 {
        return "NO"
    }
    
    for bracket in brackets {
        
        if bracket == "(" || bracket == "[" || bracket == "{" {
            stack.push(bracket)
            
        } else {
            let popped: Character?  =   stack.pop()
            isBalanced              =   compareBrackets(startingBracket: popped, endingBracket: bracket)
            
            if !isBalanced {
                return "NO"
            }
        }
        
    }
    
    return "YES"
}

func compareBrackets(startingBracket: Character?, endingBracket: Character) -> Bool {
    
    guard let startingBracket = startingBracket else { return false }
    
    if startingBracket == "(" && endingBracket == ")" {
        return true
    } else if startingBracket == "{" && endingBracket == "}" {
        return true
    } else if startingBracket == "[" && endingBracket == "]" {
        return true
    } else {
        return false
    }
    
}

var brackets: String = "{({}()[])[]}{}([[]])"
isBalanced(s: brackets)

//: ### My Own Implementation of Stack
struct MyOwnStack <Element>: CustomStringConvertible, ExpressibleByArrayLiteral {
    private var items: [Element] = [Element]()
    
    init(_ items: [Element]) {
        self.items = items
    }
    
    init(arrayLiteral elements: Element...) {
        self.items = elements
    }
    
    public mutating func push(_ element: Element) {
        items.append(element)
    }
    
    public mutating func pop() -> Element? {
        return items.popLast()
    }
    
    public mutating func peek() -> Element? {
        return items.last
    }
    
    public func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    var description: String {
        return "Stack: \(items.map{"\($0)"}.reversed().joined(separator: " - "))"
    }
}

var myStack: MyOwnStack = [1, 2, 3]
myStack.push(1)
myStack.push(2)
myStack.push(3)
myStack.push(4)
myStack.push(5)
myStack.pop()
print(myStack)

myStack.isEmpty()

//: ### Nodes

class MyOwnNode<Value> : CustomStringConvertible {
    
    private var _value:  Value
    private var _next:   MyOwnNode?
    
    public init(value: Value, next: MyOwnNode? = nil){
        self._value = value
        self._next = next
    }
    
    public var value: Value {
        get {
            return _value
        }
        
        set {
            _value = newValue
        }
    }
    
    public var next: MyOwnNode? {
        get {
            return _next
        }
        
        set {
            _next = newValue
        }
    }
    
    var description: String {
        guard let next = _next else {
            return "\(self._value)"
        }
        
        return "\(_value) -> \(String(describing: next))"
    }
    
}

let mon     =   MyOwnNode(value: 1)
let mon1    =   MyOwnNode(value: 2)
let mon2    =   MyOwnNode(value: 3)

mon.value   =   6
mon.next    =   mon1
mon1.next   =   mon2


//: ### My LinkedList

struct MyLinkedList<Value>: CustomStringConvertible {
    
    public var head: MyOwnNode<Value>?
    public var tail: MyOwnNode<Value>?
    
    public init(){}
    
    public mutating func push(_ value: Value) {
        head = MyOwnNode(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var description: String {
        guard let head = head else {
            return "Empty LinkedList"
        }
        
        return "\(head)"
    }
    
}
