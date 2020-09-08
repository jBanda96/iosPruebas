import Foundation

protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

extension Bird {
    var canFly: Bool { return self is Flyable }
}

protocol Flyable {
    var airspeedVelocity: Double { get }
}

protocol Cheat {
    mutating func boost(_ power: Double)
}

extension CustomStringConvertible where Self: Bird {
    var description: String {
        return canFly ? "I can fly" : "Guess I'll just sit here :["
    }
}

struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    
    var airspeedVelocity: Double {
        return 3 * flappyFrequency * flappyAmplitude
    }
}

extension FlappyBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}


struct Penguin: Bird {
    let name: String
}

extension Penguin: Racer {
    var speed: Double {
        return 42.0
    }
}

struct SwiftBird: Bird, Flyable {
    var name: String { "Swift \(version)" }
    let version: Double
    private var speedFactor = 1_000.00
    
    init(version: Double) {
        self.version = version
    }
    
    var airspeedVelocity: Double {
        version * speedFactor
    }
    
}

extension SwiftBird: Racer {
    var speed: Double {
        return airspeedVelocity
    }
}

extension SwiftBird: Cheat {
    mutating func boost(_ power: Double) {
        speedFactor += power
    }
}

enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown
    
    var canFly: Bool {
        self != .unknown
    }
    
    var name: String {
        switch self {
        case .african:
            return "African"
        case .european:
            return "European"
        case .unknown:
            return "Unknown"
        }
    }
    
    var airspeedVelocity: Double {
        switch self {
        case .african:
            return 10.0
        case .european:
            return 9.9
        case .unknown:
            fatalError("You are thrown from the bridge of death!")
        }
        
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        canFly ? airspeedVelocity : 0.0
    }
}

protocol Racer {
    var speed: Double { get }
}

class Motorcycle: Racer {
    var name: String
    var speed: Double
    
    init(name: String) {
        self.name = name
        self.speed = 200
    }
}

let racers: [Racer] = [
    UnladenSwallow.african,
    UnladenSwallow.european,
    UnladenSwallow.unknown,
    Penguin(name: "King Penguin"),
    Penguin(name: "Real Penguin"),
    SwiftBird(version: 1.0),
    SwiftBird(version: 2.0),
    FlappyBird(name: "Felipe", flappyAmplitude: 3.0, flappyFrequency: 20.0),
    Motorcycle(name: "Giacomo")
]

racers.forEach {
    print($0.speed)
}


func topSpeed<RacersType: Sequence>(of racers: RacersType) -> Double  where RacersType.Iterator.Element == Racer {
    racers.max(by: { $0.speed < $1.speed })?.speed ?? 0.0
}

topSpeed(of: racers)

 


protocol Score: Comparable {
    var value: Int { get }
}

struct RacingScore: Score {
    let value: Int
    
    static func < (lhs: RacingScore, rhs: RacingScore) -> Bool {
        return lhs.value < rhs.value
    }
}

class Service {
    var id: String
    
    init(id: String) {
        self.id = id
    }
}

let services = [Service(id: "no"), Service(id: "appoinment")]
services.contains { service -> Bool in
    service.id == "appoinment"
}



enum BGMLocationType: String {
    case atm
    case branch
    case kiosk
}

let atm: BGMLocationType = .atm
let branch: BGMLocationType = .branch
let kiosk: BGMLocationType = .kiosk

atm
branch
kiosk.rawValue

