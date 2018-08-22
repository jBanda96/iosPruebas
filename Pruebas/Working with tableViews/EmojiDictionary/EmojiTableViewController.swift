//
//  EmojiTableViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 16/08/18.
//  Copyright © 2018 Julio Banda. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [[Emoji]] = [
        [Emoji(symbol: "😀", name: "Grinning Face", describing: "A typical smiley face.", usage: "happiness", group: .people),
         Emoji(symbol: "😕", name: "Confused Face", describing: "A confused, puzzled face.", usage: "unsurewhat to think; displeasure", group: .people),
         Emoji(symbol: "😍", name: "Heart Eyes", describing: "A smiley face with hearts for eyes.", usage: "love of something; attractive", group: .people),
         Emoji(symbol: "👮", name: "Police Officer", describing: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority", group: .people)],
        
        [Emoji(symbol: "🐢", name: "Turtle", describing: "A cute turtle.", usage: "Something slow", group: .animalsAndNature),
         Emoji(symbol: "🐘", name: "Elephant", describing: "A gray elephant.", usage: "good memory", group: .animalsAndNature),
         Emoji(symbol: "🍝", name: "Spaghetti", describing: "A plate of spaghetti.", usage: "spaghetti", group: .foodAndDrink)],
        
        [Emoji(symbol: "🎲", name: "Die", describing: "Asingle die.", usage: "taking a risk, chance; game", group: .activity),
         Emoji(symbol: "⛺️", name: "Tent", describing: "A small tent.", usage: "camping", group: .activity),
         Emoji(symbol: "📚", name: "Stack of Books", describing: "Three colored books stacked on each other.", usage: "homework, studying", group: .activity)],
        
        [Emoji(symbol: "💔", name: "Broken Heart", describing: "A red, broken heart.", usage: "extreme sadness", group: .symbols),
         Emoji(symbol: "💤", name: "Snore", describing: "Three blue \'z\'s.", usage: "tired, sleepiness", group: .symbols),
         Emoji(symbol: "🏁", name: "Checkered Flag", describing: "A black-and-white checkered flag.", usage: "completion", group: .symbols)]]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    // MARK: - Table view data source and delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            
        case 0:
            return "People"
            
        case 1:
            return "Animals and Nature"
            
        case 2:
            return "Activity"
            
        case 3:
            return "Symbols"
            
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        let emoji = emojis[indexPath.section][indexPath.row]
        
        cell.update(with: emoji)
        cell.showsReorderControl = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row != 0
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return indexPath.row % 2 == 0 ? .delete : .insert
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        
        if editingStyle == .delete {
            emojis[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
        
        tableView.endUpdates()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.section][indexPath.row]
            
            let addEditEmojiTableViewController = segue.destination as! AddEditEmojiTableViewController
            addEditEmojiTableViewController.emoji = emoji
        }
    }

    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "save" else { return }
        
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.section][selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                
            } else {
                let newIndexPath = IndexPath(row: emojis[0].count, section: 0)
                emojis[0].append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
    }
    
    private func showEdit(_ emoji: Emoji) {
        let messageController = UIAlertController(title: "Edit Emoji", message: "\(emoji.description)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            messageController.dismiss(animated: true, completion: nil)
        }
        
        messageController.addAction(action)
        
        self.present(messageController, animated: true, completion: nil)
    }
    
}
