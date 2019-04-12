//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport


protocol GreetingView: class {
    func setGreeting(greetings: String)
}

protocol GreetingViewPresenter {
    init(view: GreetingView, person: Person)
    func showGreeting()
}

struct Person {
    let name:       String
    let surname:    String
}

class GreetingPresenter: GreetingViewPresenter {
    
    unowned let view: GreetingView
    let person: Person
    
    required init(view: GreetingView, person: Person) {
        self.view = view
        self.person = person
    }
    
    func showGreeting() {
        self.view.setGreeting(greetings: "Hello \(person.name) \(person.surname)")
    }
}

class GreetingViewController: UIViewController, GreetingView {
    
    var presenter: GreetingViewPresenter!
    
    let showGreetingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
        button.setTitle("Greet!!", for: .normal)
        return button
    }()
    
    let greetingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(showGreetingButton)
        self.showGreetingButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapButton(_ button: UIButton) {
        presenter.showGreeting()
    }
    
    func setGreeting(greetings: String) {
        self.greetingLabel.text = greetings
    }
}

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = GreetingViewController()
//: [Next](@next)
