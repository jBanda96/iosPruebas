//
//  GameScoreboardEditorViewModel.swift
//  Pruebas
//
//  Created by Julio Banda on 4/6/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

protocol GameScoreboardEditorViewModel {
    
    var homePlayers: [PlayerScoreBoardViewModel] { get }
    var awayPlayers: [PlayerScoreBoardViewModel] { get }
    
    var homeTeam: String { get }
    var awayTeam: String { get }
    var time: String { get }
    var score: String { get }
    var isFinished: Bool { get }
    
    var isPaused: Bool { get }
    
    func togglePause()
}
