
//: ### Bubble sort
var bubbleArray = [4, 3, 6, 2, 1, 7]

for i in 2 ... bubbleArray.count {
    for j in 0 ... bubbleArray.count - i {
     
        print("\(bubbleArray[j]) - \(bubbleArray[j + 1])")
        
        if bubbleArray[j] > bubbleArray[j + 1] {
            let aux = bubbleArray[j]
            bubbleArray[j] = bubbleArray[j + 1]
            bubbleArray[j + 1] = aux
        }
        
        
    }
}

bubbleArray
