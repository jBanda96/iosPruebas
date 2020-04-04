//
//  MementoViewController.swift
//  Pruebas
//
//  Created by Banda Castillo Julio on 4/2/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit

class MementoViewController: UIViewController {
    
    @IBOutlet weak var firstTextField:      UITextField!
    @IBOutlet weak var secondTextField:     UITextField!
    @IBOutlet weak var thirdTextField:      UITextField!
    @IBOutlet weak var `switch`:            UISwitch!
    @IBOutlet weak var progressView:        UISlider!
    @IBOutlet weak var segmentedControl:    UISegmentedControl!
    
    let viewModel = OriginatorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTap()
    }

    @IBAction func save(_ sender: UIButton) {
        viewModel.originator = Originator()
        viewModel.originator?.state.setTitle(to: firstTextField.text)
        viewModel.originator?.state.setSecond(to: secondTextField.text)
        viewModel.originator?.state.setThird(to: thirdTextField.text)
        viewModel.originator?.state.setSwitch(to: `switch`.isOn)
        viewModel.originator?.state.setProgress(to: Double(progressView.value))
        viewModel.originator?.state.setSegment(to: segmentedControl.selectedSegmentIndex)
        
        try? CareTaker.shared.save(viewModel.originator)
    }
    
    @IBAction func load(_ sender: UIButton) {
        viewModel.originator = CareTaker.shared.load(firstTextField.text)
        
        firstTextField.text = viewModel.firstText
        secondTextField.text = viewModel.secondText
        thirdTextField.text = viewModel.thirdText
        `switch`.setOn(viewModel.switch, animated: true)
        progressView.setValue(viewModel.progress, animated: true)
        segmentedControl.selectedSegmentIndex = viewModel.segmentedIndex
    }
    
    private func configTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(sender:)))
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func didTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "saved" {
            let viewController = segue.destination as? SavedOriginatorsViewController
            viewController?.delegate = self
        }
        
    }
    
}

extension MementoViewController: SavedProtocol {
    func didSelectSaved(_ viewController: SavedOriginatorsViewController?, originator: Originator?) {
        viewModel.originator = originator
        
        firstTextField.text = viewModel.firstText
        secondTextField.text = viewModel.secondText
        thirdTextField.text = viewModel.thirdText
        `switch`.setOn(viewModel.switch, animated: true)
        progressView.setValue(viewModel.progress, animated: true)
        segmentedControl.selectedSegmentIndex = viewModel.segmentedIndex
    }
}

class OriginatorViewModel {
    
    fileprivate(set) var originator: Originator?
    
    var firstText: String? {
        return originator?.state.first
    }
    
    var secondText: String? {
        return originator?.state.second
    }
    
    var thirdText: String? {
        return originator?.state.third
    }
    
    var `switch`: Bool {
        return originator?.state.switch ?? false
    }
    
    var progress: Float {
        guard let progress = originator?.state.progress else { return 0.5 }
        return Float(progress)
    }
    
    var segmentedIndex: Int {
        return originator?.state.segment ?? 0
    }
    
}

class Originator: Codable {
    class State: Codable {
        private(set) var first:      String?
        private(set) var second:     String?
        private(set) var third:      String?
        private(set) var `switch`:   Bool    = false
        private(set) var progress:   Double  = 0.5
        private(set) var segment:    Int     = 0
        
        func setTitle(to string: String?) {
            self.first = string
        }
        
        func setSecond(to string: String?) {
            self.second = string
        }
        
        func setThird(to string: String?) {
            self.third = string
        }
        
        func setSwitch(to bool: Bool) {
            self.switch = bool
        }
        
        func setProgress(to double: Double) {
            self.progress = double
        }
        
        func setSegment(to int: Int) {
            self.segment = int
        }
        
    }
    
    private(set) var state = State()
}

class CareTaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let userDefaults = UserDefaults.standard
    
    private let allOriginators = "allOriginators"
    
    static let shared = CareTaker()
    
    private init() { }
    
    public var all: [Originator?]? {
        guard let originatorsData = userDefaults.data(forKey: allOriginators),
            let originators = try? decoder.decode([Originator].self, from: originatorsData)
            else { return nil }
        return originators
    }
    
    public func save(_ originator: Originator?) throws {
        if let title = originator?.state.first, title != "", !alreadySaved(title) {
            let data = try encoder.encode(originator)
            userDefaults.set(data, forKey: title)
            
            var all = self.all
            if all == nil {
                all = [Originator]()
            }
            
            all?.append(originator)
            
            let allEncoded = try? encoder.encode(all)
            userDefaults.set(allEncoded, forKey: allOriginators)
        }
    }
    
    public func load(_ string: String?) -> Originator? {
        guard let title = string,
            let data = userDefaults.data(forKey: title),
            let object = try? decoder.decode(Originator.self, from: data) else { return nil }
        return object
    }
    
    private func alreadySaved(_ string: String) -> Bool {
        for originator in self.all ?? [] {
            if originator?.state.first == string {
                return true
            }
        }
        return false
    }
    
}
