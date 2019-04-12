//
//  PlayerScoreBoardViewModel.swift
//  Pruebas
//
//  Created by Julio Banda on 4/7/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

protocol PlayerScoreBoardViewModel {
    
    var playerName: String { get }
    
    var onePointMoveCount: String { get }
    var twoPointMoveCount: String { get }
    var assistMoveCount: String { get }
    var reboundMoveCount: String { get }
    var foulMoveCount: String { get }
    
    func onePointMove()
    func towPointsMove()
    func assistMove()
    func reboundMove()
    func foulMove()
}
