//: [Previous](@previous)

import PlaygroundSupport
import UIKit


//: Model
public class Pet {
    
    public enum Rarity {
        case common
        case uncommon
        case rare
        case veryRare
    }
    
    let name:       String
    let rarity:     Rarity
    let image:      UIImage
    let birthday:   Date
    
    public init (name: String, rarity: Rarity, birthday: Date, image: UIImage) {
        self.name       =   name
        self.rarity     =   rarity
        self.birthday   =   birthday
        self.image      =   image
    }
    
}


//: ViewModel

public class PetViewModel {
    
    // Private properties
    private let pet: Pet
    private let calendar: Calendar
    
    // Initializer
    public init(pet: Pet) {
        self.pet = pet
        self.calendar = Calendar(identifier: .gregorian)
    }
    
    // Computed Properties
    public var name: String {
        return pet.name
    }
    
    public var image: UIImage {
        return pet.image
    }
    
    public var ageText: String {
        
        let today       =   calendar.startOfDay(for: Date())
        let birthday    =   calendar.startOfDay(for: pet.birthday)
        let components  =   calendar.dateComponents([.year], from: birthday, to: today)
        
        let age = components.year ?? -1
        return "\(age) years old"
    }
    
    public var adoptionFeeText: String {
        switch pet.rarity {
        case .common:
            return "$50.00"
            
        case .uncommon:
            return "$75.00"
            
        case .rare:
            return "$150.00"
            
        case .veryRare:
            return "$500.00"
        }
    }
}

extension PetViewModel {
    func configure(_ view: PetView) {
        view.imageView.image        =   image
        view.nameLabel.text         =   name
        view.ageLabel.text          =   ageText
        view.adoptionFeeLabel.text  =   adoptionFeeText
    }
}

//: View

class PetView: UIView {
    
    let imageView:          UIImageView
    let nameLabel:          UILabel
    let ageLabel:           UILabel
    let adoptionFeeLabel:   UILabel
    
    public override init(frame: CGRect) {
        
        var childFrame = CGRect(x: 0, y: 16, width: frame.width, height: frame.height / 2)
        
        imageView = UIImageView(frame: childFrame)
        imageView.contentMode = .scaleAspectFit
        
        childFrame.origin.y += childFrame.height + 16
        childFrame.size.height = 30
        nameLabel = UILabel(frame: childFrame)
        nameLabel.textAlignment = .center
        
        childFrame.origin.y += childFrame.height
        ageLabel = UILabel(frame: childFrame)
        ageLabel.textAlignment = .center
        
        childFrame.origin.y += childFrame.height
        adoptionFeeLabel = UILabel(frame: childFrame)
        adoptionFeeLabel.textAlignment = .center
        
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(adoptionFeeLabel)
        
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is not supported")
    }
    
}

let birthday = Date(timeIntervalSinceNow: (-2 * 86400 * 366))
let roger = Pet(name: "Roger", rarity: .uncommon, birthday: birthday, image: #imageLiteral(resourceName: "roger.jpeg"))

let petViewModel = PetViewModel(pet: roger)

let frame = CGRect(x: 0, y: 0, width: 300, height: 420)
let view = PetView(frame: frame)

petViewModel.configure(view)


PlaygroundPage.current.liveView = view

//: [Next](@next)


