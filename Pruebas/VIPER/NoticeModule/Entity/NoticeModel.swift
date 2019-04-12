//
//  NoticeModel.swift
//  Pruebas
//
//  Created by Julio Banda on 4/10/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class NoticeModel: Codable {
    
    internal var id:            String?
    internal var title:         String?
    internal var brief:         String?
    internal var filesource:    String?
    
    init(id: String, title: String, brief: String, filesource: String) {
        self.id         = id
        self.title      = title
        self.brief      = brief
        self.filesource = filesource
    }
    
}
