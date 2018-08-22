//
//  AddEditEmojiTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 18/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "flowers"))
        backgroundImage.translatesAutoresizingMaskIntoConstraints = true
        
        return backgroundImage
    }()
    
    var emoji: Emoji?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundView = backgroundImage
        
        if let emoji = self.emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.describing
            usageTextField.text = emoji.usage
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        
        guard segue.identifier == "save" else { return }
        
        let symbol = symbolTextField.text ?? ""
        let name = nameTextField.text
        let description = descriptionTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        
        emoji = Emoji(symbol: symbol, name: name, describing: description, usage: usage, group: .activity)
        
    }

}
