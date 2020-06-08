//
//  AddRegistrationTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 29/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    // MARK: - Outlets and stored properties
    @IBOutlet weak var firtsNameTextField:  UITextField!
    @IBOutlet weak var lastNameTextField:   UITextField!
    @IBOutlet weak var emailTextField:      UITextField!
    
    @IBOutlet weak var checkInDateLabel:    UILabel!
    @IBOutlet weak var checkOutDateLabel:   UILabel!
    @IBOutlet weak var checkInDatePicker:   UIDatePicker!
    @IBOutlet weak var checkOutDatePicker:  UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel:     UILabel!
    @IBOutlet weak var numberOfAdultsStepper:   UIStepper!
    @IBOutlet weak var numberOfChildrenLabel:   UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    var roomType: RoomType?
    
    @IBOutlet weak var birthdateDate:   UITextField!
    @IBOutlet weak var doneToolbar:     UIToolbar!
    @IBOutlet weak var datePicker:      UIDatePicker!
    
    let checkInDatePickerCellIndexPath      =   IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath     =   IndexPath(row: 3, section: 1)
    let birthdateDatePickerCellIndexPath    =   IndexPath(row: 0, section: 5)
    
    // MARK: - Computed properties
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                self.checkInDatePicker.isHidden = !self.isCheckInDatePickerShown
            }
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    let dateString = "Wed, 03 Jun 2020 05:30:00 GMT"
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
//            let randomNumber = Int.random(in: 1...20)
//            print("Number: \(randomNumber)")
//
//            if randomNumber == 10 {
//                timer.invalidate()
//            }
//        }
        
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(generateRandomNumber), userInfo: nil, repeats: true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EE, dd MMM yyyy hh:mm:ss ZZZZ"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        if let date = formatter.date(from: dateString) {
            //540seconds -> 9minutes
            
            let seconds = Date() - date
            if seconds <= 540 {
                print("Aún tenemos tiempo")
            } else {
                print("Han pasado 9 minutos o más")
            }
        }

        let midnightToday = Calendar.autoupdatingCurrent.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
        setInputs()
    }
    
    override func viewDidDisappear(_ animated: Bool)  {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    
    // MARK: - IBActions
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem){
        let firstName = firtsNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        
        let hasWifi = wifiSwitch.isOn
        
        let roomType = self.roomType?.name ?? "Not Set"
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func cancelBarButtonTapped(_ sender: UIBarButtonItem){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper){
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: UISwitch){ }
    
    @IBAction func birthdayChanged(_ picker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd / MM / yyyy"
        
        birthdateDate.text = formatter.string(from: picker.date)
    }
    
    @IBAction func done(_ button: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    // MARK: - Timer
    var timer: Timer?
    
    @objc func generateRandomNumber() {
        let randomNumber = Int.random(in: 1...20)
        print("Number: \(randomNumber)")
        
        if randomNumber == 10 {
            self.timer?.invalidate()
        }
    }
    
    // MARK: - Private functions
    private func updateDateViews(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        
        checkOutDatePicker.minimumDate = checkInDatePicker.minimumDate?.addingTimeInterval(86400)
    }

    private func updateNumberOfGuests(){
        numberOfAdultsLabel.text = String(Int(numberOfAdultsStepper.value))
        numberOfChildrenLabel.text = String(Int(numberOfChildrenStepper.value))
    }
    
    private func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    private func setInputs() {
        self.birthdateDate.inputView = datePicker
        self.birthdateDate.inputAccessoryView = doneToolbar
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectRoomType" {
            let destinationViewController = segue.destination as? SelectRoomTypeTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.roomType = roomType
        }
    }
    
}


// MARK: - UITableView Delegate and Data source
extension AddRegistrationTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row - 1):
            
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckInDatePickerShown = true
                isCheckOutDatePickerShown = false
            } else {
                isCheckInDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row - 1):
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckOutDatePickerShown = true
                isCheckInDatePickerShown = false
            } else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (checkInDatePickerCellIndexPath.section, checkInDatePickerCellIndexPath.row):
            if isCheckInDatePickerShown {
                return 216
            } else {
                return 0
            }
            
        case (checkOutDatePickerCellIndexPath.section, checkOutDatePickerCellIndexPath.row):
            if isCheckOutDatePickerShown {
                return 216
            } else {
                return 0
            }
            
        case (birthdateDatePickerCellIndexPath.section, birthdateDatePickerCellIndexPath.row):
            return 80
            
        default:
            return 44
        }
    }
}

// MARK: - SelectRoomType Conformation
extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerDelegate {
    internal func didSelect(roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
}

// MARK: - Date extension
extension Date {
    static func -(lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
