//
//  Game.swift
//  Pruebas
//
//  Created by Julio Banda on 4/5/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import Foundation

struct Game {
    let matchingWinningScore: Int = 15
    
    let identifier: String
    var homeTeam: Team
    var awayTeam: Team
    var homeTeamScore: UInt = 0
    var awayTeamScore: UInt = 0
    
    var time: TimeInterval  =   0.0
    var isFinished: Bool    =   false
    
    init(homeTeam: Team, awayTeam: Team, identifier: String) {
        self.identifier = identifier
        
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        
        self.moveHistory = []
    }
    
    fileprivate var moveHistory: [(move: PlayerInGameMove, player: Player)] = []
    
    mutating func addPlayerMove(_ move: PlayerInGameMove, for player: Player) {
        
        if !containsPlayer(player) {
            print("Player not found in this game")
            return
        }
        
        switch move {
        
        case .onePoint:
            updateScore(1, withScoringPlayer: player)
            
        case .twoPoints:
            updateScore(2, withScoringPlayer: player)
            
        case .assist:   return
            
        case .rebound:  return
            
        case .foul:     return
        }
        
    }
    
    mutating func playerMoveCount(for player: Player, move: PlayerInGameMove) -> UInt{
        var moveCount: UInt = 0
        
        for currentMove in moveHistory {
            if currentMove.move == move && currentMove.player.identifier == player.identifier {
                moveCount += 1
            }
        }
        
        return moveCount
    }
    
    func isScoringMove(_ move: PlayerInGameMove) -> Bool {
        return move == .onePoint || move == .twoPoints
    }
    
    // MARK: - Private
    fileprivate func containsPlayer(_ player: Player) -> Bool {
        var contains = false
        
        contains = homeTeam.containsPlayer(player)
        
        if !contains {
            contains = awayTeam.containsPlayer(player)
        }
        
        return contains
    }
    
    fileprivate mutating func updateMoveHistory(with move: PlayerInGameMove, for player: Player) {
        self.moveHistory.append((move, player))
    }
    
    fileprivate mutating func updateScore(_ score: UInt, withScoringPlayer player: Player) {
        
        if isFinished || score == 0 {
            return
        }
        
        if homeTeam.containsPlayer(player) {
            homeTeamScore += score
        } else {
            assert(awayTeam.containsPlayer(player))
            awayTeamScore += score
        }
        
        if checkIfinished() {
            isFinished = true
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification), object: self)
        
    }
    
    fileprivate func checkIfinished() -> Bool {
        var isFinished = false
        
        let winningScoreReached = homeTeamScore >= matchingWinningScore || awayTeamScore >= matchingWinningScore
        
        if winningScoreReached {
            isFinished = abs(Int(awayTeamScore) - Int(homeTeamScore)) > 1
        }
        
        return isFinished
    }
    
}

enum PlayerInGameMove {
    case onePoint
    case twoPoints
    case assist
    case rebound
    case foul
}

enum GameNotifications {
    static let GameScoreDidChangeNotification = "GameScoreDidChangeNotification"
}
