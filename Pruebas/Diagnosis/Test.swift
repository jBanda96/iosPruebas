//
//  Test.swift
//  Pruebas
//
//  Created by Julio Banda on 28/09/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import LATAMDeviceSDK

struct Test {
    
    enum Status: String {
        case passed = "bien"
        case failed = "mal"
        case onCourse
        case notStartedYet
    }
    
    let name: String
    let type: LTDSDKHealthCheckType
    var status: Status = .notStartedYet
}
