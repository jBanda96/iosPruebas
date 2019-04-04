//: [Previous](@previous)

import PlaygroundSupport
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true
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




//: ### Another Example

struct Person {
    let name:       String
    let nickname:   String
    let age:        Int
    let amount:     NSNumber
    
    static let persons = [
        Person(name: "T'Challa",                            nickname: "Black Panter",   age: 34,    amount: 500_000_000_000),
        Person(name: "Anthony Edward Stark",                nickname: "Iron Man",       age: 40,    amount: 100_000_000_000),
        Person(name: "Bruno Díaz",                          nickname: "Batman",         age: 40,    amount: 80_000_000_000),
        Person(name: "Alexander Joseph Luthor",             nickname: "Lex Luthor",     age: 45,    amount: 75_000_000_000),
        Person(name: "Victor von Muerte",                   nickname: "Dr. Doom",       age: 45,    amount: 35_000_000_000),
        Person(name: "Oliver Jonas Queen",                  nickname: "Green Arrow",    age: 32,    amount: 7_000_000_000),
        Person(name: "Charles Francis Xavie",               nickname: "Professor X",    age: 60,    amount: 3_500_000_000),
        Person(name: "Erik Lehnsher",                       nickname: "Magneto",        age: 61,    amount: 500_000_000)
    ]
}


struct PersonViewModel: CustomStringConvertible {
    
    private let person: Person
    private let formatter: NumberFormatter

    init(person: Person) {
        self.person = person
        self.formatter = NumberFormatter()
    }
    
    public var name: String {
        return person.name
    }
    
    public var nickname: String {
        return person.nickname
    }
    
    public var age: Int {
        return person.age
    }
    
    public var amount: String {
        formatter.numberStyle   =   .currency
        formatter.locale        =   Locale(identifier: "es_MX")
        formatter.usesGroupingSeparator = true
        
        return formatter.string(from: person.amount) ?? "$0.00"
    }
    
    public var description: String {
        return "Person(name: \(name), nickname: \(nickname), age: \(age), amount: \(amount))"
    }
    
}

class PersonView: UITableViewController {
    
    let persons = Person.persons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PersonCell.self, forCellReuseIdentifier: "cell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonCell
        cell.personViewModel = PersonViewModel(person: persons[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(PersonViewModel(person: persons[indexPath.row]).description)
    }
    
}

class PersonCell: UITableViewCell {
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstStack, secondStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        return stack
    }()
    
    lazy var firstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, nicknameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 4

        return stack
    }()
    
    lazy var secondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ageLabel, amountLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        return stack
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.font = .boldSystemFont(ofSize: 12)
        
        return name
    }()
    
    let nicknameLabel: UILabel = {
        let nickname = UILabel()
        nickname.font = .systemFont(ofSize: 12, weight: .light)
        
        return nickname
    }()
    
    let ageLabel: UILabel = {
        let age = UILabel()
        age.font = .systemFont(ofSize: 12, weight: .light)
        
        return age
    }()
    
    let amountLabel: UILabel = {
        let amount = UILabel()
        amount.font = .systemFont(ofSize: 12, weight: .light)
        
        return amount
    }()
    
    var personViewModel: PersonViewModel! {
        didSet {
            configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(stack)
        NSLayoutConstraint.activate(
            [
                stack.topAnchor.constraint      (equalTo: topAnchor,        constant: 8     ),
                stack.leadingAnchor.constraint  (equalTo: leadingAnchor,    constant: 16    ),
                stack.trailingAnchor.constraint (equalTo: trailingAnchor,   constant: -16   ),
                stack.bottomAnchor.constraint   (equalTo: bottomAnchor,     constant: -8    )
            ]
        )
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        nameLabel.text          =       "Nombre: \(personViewModel.name)"
        nicknameLabel.text      =       personViewModel.nickname
        ageLabel.text           =       "Edad: \(personViewModel.age)"
        amountLabel.text        =       "Dinero: \(personViewModel.amount)"
    }
    
}

let vc = PersonView()
PlaygroundPage.current.liveView = vc

//: [Next](@next)


