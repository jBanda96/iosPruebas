//
//  Card.swift
//  Pruebas
//
//  Created by Julio Banda on 22/03/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import Foundation

struct Card: Hashable {
    let name: String

    var image: UIImage {
        return UIImage(named: name)!
    }
}
