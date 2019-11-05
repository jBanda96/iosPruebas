//: ### Observer Pattern
//: El patrón observador permite observar cambios en otro objeto
import Foundation

// MARK: - KVO

@objcMembers public class KVOUser: NSObject {
    dynamic var name: String
    dynamic var age: Int
    
    public init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


print("-- KVO Example --")

let kvoUser = KVOUser(name: "Ray", age: 12)

var kvoObserver: NSKeyValueObservation? = kvoUser.observe(\.age, options: [.initial, .new]) { (user, change) in
        print("User's name is \(user.age)")
    }



kvoUser.name = "Julio"
kvoUser.age = 23
