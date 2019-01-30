//
//  CollectionViewController.swift
//  Pruebas
//
//  Created by Julio Banda on 1/26/19.
//  Copyright © 2019 Julio Banda. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    @IBOutlet private weak var addButton: UIBarButtonItem!

    var pets: [String] = ["Rogger 🐶", "Pelusa 🐱" , "Cosmo 🐹", "Bingo 🐶", "Alex 🦁", "Valiant 🐽", "Blue 🦋", "Rene 🐸", "Scar 🐯", "Mufasa 🦁"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 16) / 3
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: width)
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        self.collectionView?.refreshControl = refresh
        
        navigationItem.rightBarButtonItems = [editButtonItem, addButton, deleteButton]
        
        installsStandardGestureForInteractiveMovement = true
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.isEnabled = !editing
        deleteButton.isEnabled = editing
        
        self.collectionView?.allowsMultipleSelection = editing
        self.collectionView?.indexPathsForSelectedItems?.forEach {
            self.collectionView?.deselectItem(at: $0, animated: false)
        }
        
        let indexPaths = self.collectionView!.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = self.collectionView?.cellForItem(at: indexPath) as! PetsCell
            cell.isEditing = editing
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let dest = segue.destination as? DetailSegueViewController, let index = sender as? IndexPath {
                dest.selection = pets[index.row]
            }
        }
    }
    
    @objc func refresh(){
        addItem(nil)
        self.collectionView?.refreshControl?.endRefreshing()
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem?){
        let insertingItem:      String      =   "Spirit 🐴"
        pets.append(insertingItem)
        
        let indexPathToInsert:  IndexPath   =   IndexPath(row: pets.count - 1, section: 0)
        
        let layout = collectionView?.collectionViewLayout as! FlowLayout
        layout.addedItem = indexPathToInsert
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: [], animations: {
            self.collectionView?.insertItems(at: [indexPathToInsert])
        }) { (finish) in
            layout.addedItem = nil
        }
        
    }
    
    @IBAction func deleteItem(_ sender: UIBarButtonItem){
        if let selectedIndexPaths = self.collectionView?.indexPathsForSelectedItems {
            for selectedIndexPath in selectedIndexPaths.reversed() {
                pets.remove(at: selectedIndexPath.item)
            }
            
            let layout = collectionView?.collectionViewLayout as! FlowLayout
            layout.deletedItems = selectedIndexPaths
            self.collectionView?.deleteItems(at: selectedIndexPaths)
        }
    }
    
}

extension CollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !isEditing {
            //print("You did select: \(pets[indexPath.row])")
            self.performSegue(withIdentifier: "detailSegue", sender: indexPath)
        }
    }
    
}

extension CollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PetsCell
        cell.titleLabel.text = pets[indexPath.row]
        
        cell.isEditing = isEditing
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removedItem = pets.remove(at: sourceIndexPath.row)
        pets.insert(removedItem, at: destinationIndexPath.row)
    }
}
