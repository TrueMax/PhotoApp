//
//  ObjectTableViewController.swift
//  photoapp
//
//  Created by Maxim on 17.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

// отображение списка объектов, сюда же UISearchController впишется 
// кнопка "Обновить" -> reloadData()
// pull-to-refresh -> refreshControl
// didSelect -> CollectionView (Image)
// 


import UIKit

class ObjectTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.clearsSelectionOnViewWillAppear = false
        navigationItem.title = "ВРЕМЕННО ТУТ"
        
        tableView.register(ObjectTableViewCell.self, forCellReuseIdentifier: "titleCell")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! ObjectTableViewCell
        
        cell.textLabel?.text = "HELLO CITIZEN"

        return cell
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        layout.scrollDirection = .horizontal
        let collectionViewController = ImageCollectionViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(collectionViewController, animated: true)
    }

}
