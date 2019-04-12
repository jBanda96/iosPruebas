//
//  PlayerScoreBoardMoveEditorViewModelFromPlayer.swift
//  Pruebas
//
//  Created by Julio Banda on 4/7/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

class PlayerScoreBoardMoveEditorViewModelFromPlayer: NSObject, PlayerScoreBoardViewModel {
    
    fileprivate var game: Game
    fileprivate var player: Player
    
    var playerName: String
    
    var onePointMoveCount: String
    
    var twoPointMoveCount: String
    
    var assistMoveCount: String
    
    var reboundMoveCount: String
    
    var foulMoveCount: String
    
    init(withGame game: Game, player: Player) {
        
        self.game = game
        self.player = player
        
        self.playerName = player.name
        
        self.onePointMoveCount   =   "\(self.game.playerMoveCount(for: player, move: .onePoint)))"
        self.twoPointMoveCount   =   "\(self.game.playerMoveCount(for: player, move: .twoPoints))"
        self.assistMoveCount     =   "\(self.game.playerMoveCount(for: player, move: .assist))"
        self.reboundMoveCount    =   "\(self.game.playerMoveCount(for: player, move: .rebound))"
        self.foulMoveCount       =   "\(self.game.playerMoveCount(for: player, move: .foul))"
    }
    
    func onePointMove() {
        makeMove(.onePoint)
    }
    
    func towPointsMove() {
        makeMove(.twoPoints)
    }
    
    func assistMove() {
        makeMove(.assist)
    }
    
    func reboundMove() {
        makeMove(.rebound)
    }
    
    func foulMove() {
        makeMove(.foul)
    }
    
    fileprivate func makeMove(_ move: PlayerInGameMove) {
        game.addPlayerMove(move, for: player)
        
        onePointMoveCount   =   "\(game.playerMoveCount(for: player, move: .onePoint))"
        twoPointMoveCount   =   "\(game.playerMoveCount(for: player, move: .twoPoints))"
        assistMoveCount     =   "\(game.playerMoveCount(for: player, move: .assist))"
        reboundMoveCount    =   "\(game.playerMoveCount(for: player, move: .rebound))"
        foulMoveCount       =   "\(game.playerMoveCount(for: player, move: .foul))"
    }
    
}
