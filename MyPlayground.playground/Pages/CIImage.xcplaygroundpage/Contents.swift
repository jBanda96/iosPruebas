import UIKit
import PlaygroundSupport


let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
container.backgroundColor = .white

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = container

let imageView = UIImageView(image: UIImage(named: "mojave.jpg"))
imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
imageView.backgroundColor = .red

container.addSubview(imageView)

