
import PlaygroundSupport
import UIKit
import AVKit

PlaygroundPage.current.needsIndefiniteExecution = true

class ViewController: UIViewController {
    
    lazy var viewForLayer: UIView  = {
        let view = UIView(frame: CGRect.init(x: 50, y: 50, width: 200, height: 200))
        return view
    }()
    
    var layer: CALayer {
        return viewForLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(viewForLayer)
        
        layer.cornerRadius      =   layer.frame.width / 2
        layer.backgroundColor   =   UIColor.gray.cgColor
        layer.borderWidth       =   5.0
        layer.borderColor       =   UIColor.black.cgColor
        layer.shadowOpacity     =   0.7
        layer.shadowRadius      =   10.0
        
        layer.contents          =   UIImage(named: "star")?.cgImage
        layer.contentsGravity   =   .resizeAspect
        
        let tap     =   UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer(_:)))
        let pinch   =   UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureRecognizer(_:)))
        
        self.view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        layer.shadowOpacity = layer.shadowOpacity == 0.7 ?  0.0 : 0.7
    }
    
    @objc func pinchGestureRecognizer(_ sender: UIPinchGestureRecognizer) {
        layer.shadowOpacity = layer.shadowOpacity == 0.7 ?  0.0 : 0.7
    }
    
}

PlaygroundPage.current.liveView = ViewController()
