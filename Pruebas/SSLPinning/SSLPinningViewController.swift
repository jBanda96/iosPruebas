//
//  SSLPinningViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 10/18/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class SSLPinningViewController: UIViewController, URLSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        
        session.dataTask(with: URLRequest(url: URL(string: "https://www.bancomer.com")!))
            .resume()
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let serverTrust = challenge.protectionSpace.serverTrust
        let certificate = SecTrustGetCertificateAtIndex(serverTrust!, 0)
        
        // Set SSL policies for domain name check
        let policies = NSMutableArray()
        policies.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
        SecTrustSetPolicies(serverTrust!, policies)
        
        // Evaluate server certificate
        var result: SecTrustResultType = .invalid
        SecTrustEvaluate(serverTrust!, &result)
        let isServerTrusted = result == SecTrustResultType.unspecified || result == SecTrustResultType.proceed
        
        //Get local and remote data
        let remoteCertificateData: NSData = SecCertificateCopyData(certificate!)
        let pathToCert = Bundle.main.path(forResource: "bancomer", ofType: "cer")
        let localCertificate = NSData(contentsOfFile: pathToCert!)!
        
        if(isServerTrusted && remoteCertificateData.isEqual(localCertificate)){
            let credential = URLCredential(trust: serverTrust!)
            completionHandler(.useCredential, credential)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
        
    }

}
