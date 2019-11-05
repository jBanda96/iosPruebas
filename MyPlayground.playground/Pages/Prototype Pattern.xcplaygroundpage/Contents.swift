import Foundation

public protocol Copying: class {
    init(_ prototype: Self)
}

extension Copying {
    public func copy() -> Self {
        return type(of: self).init(self)
    }
}


public class Monster: Copying, CustomStringConvertible {
    
    public var health: Int
    public var level: Int
    
    public var description: String {
        return "Monster: {health: \(health), level: \(level)}"
    }
    
    public init(health: Int, level: Int) {
        self.health = health
        self.level = level
    }
    
    public required convenience init(_ monster: Monster) {
        self.init(health: monster.health, level: monster.level)
    }
}

