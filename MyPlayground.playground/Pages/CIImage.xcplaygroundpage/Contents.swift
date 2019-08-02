import UIKit
import PlaygroundSupport


let container = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
container.backgroundColor = .white

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = container

let imageView = UIImageView(image: UIImage(named: "mojave.jpg"))


imageView.backgroundColor = .red
container.addSubview(imageView)


func paddinZerosToLeft(upto: Int, into string: String) -> String {
    if upto <= string.count {
        print("ssssss")
        return string
    }
    
    return String(repeatElement("0", count: upto - string.count)) + string
}


paddinZerosToLeft(upto: 3, into: "-1")
