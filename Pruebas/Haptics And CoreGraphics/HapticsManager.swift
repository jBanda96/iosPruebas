//
//  HapticsManager.swift
//  Pruebas
//
//  Created by Julio Banda on 24/11/20.
//  Copyright © 2020 Julio Banda. All rights reserved.
//

import Foundation
import CoreHaptics

class HapticsManager {
    let hapticEngine: CHHapticEngine
    
    var sliceAudio: CHHapticAudioResourceID?
    var nomNomAudio: CHHapticAudioResourceID?
    var splashAudio: CHHapticAudioResourceID?
    
    init?() {
        let hapticCapability = CHHapticEngine.capabilitiesForHardware()
        guard hapticCapability.supportsHaptics else { return nil }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine.start()
            hapticEngine.isAutoShutdownEnabled = true
            setupResources()
            
            hapticEngine.resetHandler = { [weak self] in
                self?.handleEngineReset()
            }
            
        } catch {
            print("There was an error with Core Haptics: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func setupResources() {
        do {
            if let path = Bundle.main.url(forResource: "Slice", withExtension: "caf") {
                sliceAudio = try hapticEngine.registerAudioResource(path)
            }
            
            if let path = Bundle.main.url(forResource: "NomNom", withExtension: "caf") {
                nomNomAudio = try hapticEngine.registerAudioResource(path)
            }
            
            if let path = Bundle.main.url(forResource: "Splash", withExtension: "caf") {
                splashAudio = try hapticEngine.registerAudioResource(path)
            }
            //lightsaber.mp3
        } catch {
            print("Could not load audios \(error.localizedDescription)")
        }
    }
    
    private func handleEngineReset() {
        do {
            try hapticEngine.start()
            setupResources()
        } catch {
            print(error)
        }
    }
}

extension HapticsManager {
    
    func playSlice() {
        do {
            let pattern = try slicePatter()
            
            try hapticEngine.start()
            
            let player = try hapticEngine.makePlayer(with: pattern)
            
            try player.start(atTime: CHHapticTimeImmediate)
            
            hapticEngine.notifyWhenPlayersFinished { (error) -> CHHapticEngine.FinishedAction in
                return .stopEngine
            }
            
        } catch {
            print("Failed to play slice \(error)")
        }
    }
    
    func playTap() {
        do {
            let pattern = try splashPattern()
            
            try hapticEngine.start()
            
            let player = try hapticEngine.makePlayer(with: pattern)
            
            try player.start(atTime: CHHapticTimeImmediate)
            
            hapticEngine.notifyWhenPlayersFinished { (error) -> CHHapticEngine.FinishedAction in
                return .stopEngine
            }
            
        } catch {
            print("Failed to play slice \(error)")
        }
    }
    
    private func slicePatter() throws -> CHHapticPattern {
        let slice = CHHapticEvent(eventType: .hapticContinuous,
                                  parameters: [.init(parameterID: .hapticIntensity, value: 0.6),
                                               .init(parameterID: .hapticSharpness, value: 0.8)],
                                  relativeTime: 0.0,
                                  duration: 0.5)
        
        let snip = CHHapticEvent(eventType: .hapticTransient,
                                 parameters: [
                                    .init(parameterID: .hapticIntensity, value: 1.0),
                                    .init(parameterID: .hapticSharpness, value: 1.0)
                                 ],
                                 relativeTime: 0.08)
        
        let curve = CHHapticParameterCurve(parameterID: .hapticIntensityControl,
                                           controlPoints: [
                                            .init(relativeTime: 0.0, value: 0.2),
                                            .init(relativeTime: 0.08, value: 1.0),
                                            .init(relativeTime: 0.24, value: 0.2),
                                            .init(relativeTime: 0.34, value: 0.6),
                                            .init(relativeTime: 0.5, value: 0.0)
                                           ], relativeTime: 0)
        
        var events = [slice, snip]
        
        if let audioResourceID = sliceAudio {
            let audio = CHHapticEvent(audioResourceID: audioResourceID,
                                      parameters: [],
                                      relativeTime: 0.0)
            events.append(audio)
        }
        
        return try CHHapticPattern(events: events, parameterCurves: [curve])
    }
    
    private func nomNomPattern() throws -> CHHapticPattern {
        let rumble1 = CHHapticEvent(eventType: .hapticContinuous,
                                    parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                                                 CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                    relativeTime: 0.0,
                                    duration: 0.15)
        
        let rumble2 = CHHapticEvent(eventType: .hapticContinuous,
                                    parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.4),
                                                 CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)],
                                    relativeTime: 0.3,
                                    duration: 0.3)
        
        let crunch1 = CHHapticEvent(eventType: .hapticTransient,
                                    parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                                                 CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)],
                                    relativeTime: 0.0)
        
        let crunch2 = CHHapticEvent(eventType: .hapticTransient,
                                    parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                                                 CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                                    relativeTime: 0.3)
        
        return try CHHapticPattern(events: [rumble1, rumble2, crunch1, crunch2], parameters: [])
    }
    
    private func splashPattern() throws -> CHHapticPattern {
        let splish = CHHapticEvent(eventType: .hapticTransient,
                                   parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
                                                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1)],
                                   relativeTime: 0)
        
        let splash = CHHapticEvent(eventType: .hapticContinuous,
                                   parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5),
                                                CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.1),
                                                CHHapticEventParameter(parameterID: .attackTime, value: 0.1),
                                                CHHapticEventParameter(parameterID: .releaseTime, value: 0.2),
                                                CHHapticEventParameter(parameterID: .decayTime, value: 0.3)],
                                   relativeTime: 0.1,
                                   duration: 0.6)
        
        var events = [splish, splash]
        if let audioResourceID = splashAudio {
            let audio = CHHapticEvent(audioResourceID: audioResourceID,
                                      parameters: [],
                                      relativeTime: 0)
            events.append(audio)
        }
        
        return try CHHapticPattern(events: events, parameters: [])
    }
}
