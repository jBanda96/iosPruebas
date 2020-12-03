//
//  DiagnosisViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 28/09/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import UIKit
import LATAMDeviceSDK

class DiagnosisViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var api: LTDSDKHealthCheckProtocol?
    var selectedTest: Int?
    
    var tests: [Test] = [
        ("Sensor", .Sensor),
        ("Bluetooth", .BT),
        ("Batería", .Battery),
        ("Micrófono", .Mic),
        ("Cámara Frontal", .FrontCamera),
        ("Cámara Trasera", .BackCamera),
        ("Altavoces", .Speaker),
        ("Pantalla", .Display),
    ]
    .map { Test(name: $0, type: $1) }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
    }
}

extension DiagnosisViewController: LTDSDKHealthCheckDelegate {
    func controllerDidStartHealthCheck(_ controller: LTDSDKHealthCheckProtocol) {
        print("Test started")
    }
    
    func controllerDidSucess(_ controller: LTDSDKHealthCheckProtocol) {
        guard let index = selectedTest else { return }
        
        if let _ = api as? LTDSDKDisplayHealthCheckController {
            self.navigationController?.popViewController(animated: true)
        }
        
        tests[index].status = .passed
        api?.endHealthCheck()
        tableView.reloadData()
    }
    
    func controllerDidFail(_ controller: LTDSDKHealthCheckProtocol) {
        guard let index = selectedTest else { return }
        tests[index].status = .failed
        api?.endHealthCheck()
        tableView.reloadData()
    }
}

extension DiagnosisViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath) as! TestCell
        cell.populate(with: tests[indexPath.row])
        return cell
    }
}

extension DiagnosisViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTest = indexPath.row
        
        guard let index = selectedTest else { return }
        tests[index].status = .onCourse
        
        api = LTDSDKFactory.getHealthCheckTest(testType: tests[index].type)
        
        if let camera = api as? LTDSDKCameraHealthCheckController {
            camera.setCameraType(cameraType: tests[index].type == .BackCamera ? .rear : .front)
            camera.setParentViewController(self)
        } else if let display = api as? LTDSDKDisplayHealthCheckController {
            display.setParentViewController(self)
        }
        
        api?.setHeathCheckDelegate(self)
        api?.initializeHealthCheck()
        api?.startHealthCheck()
        
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(feedback(_:)))
        self.tableView.addGestureRecognizer(tap)
        
    }
    
    @objc private func feedback(_ gesture: UIGestureRecognizer){
        let factory = FeedbackGeneratorManager.factory
        if let _ = gesture as? UITapGestureRecognizer {
            let feedback = factory.createFeedback(type: .notification)
            if let impact = feedback as? UIImpactFeedbackGenerator {
                impact.impactOccurred(intensity: 1.0)
            } else if let impact = feedback as? UISelectionFeedbackGenerator {
                impact.selectionChanged()
            } else if let impact = feedback as? UINotificationFeedbackGenerator {
                impact.notificationOccurred(.warning)
            }
        }
    }
}
