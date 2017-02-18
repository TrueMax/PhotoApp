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

class ObjectTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    var searchController = UISearchController(searchResultsController: nil)
    var searchHeaderView: UIView!
    var tableView: UITableView!
    var searchResultData: [String]?
    var initialData = ["ONE", "TWO", "THREE", "FOUR", "FIVE"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchHeaderView = UIView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: self.view.frame.width, height: 44))
        tableView = UITableView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(searchHeaderView)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.view.sendSubview(toBack: tableView)
        
        self.view.backgroundColor = UIColor.white
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.backgroundColor = UIColor.clear
        
        searchHeaderView.addSubview(searchController.searchBar)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.clipsToBounds = true
        
        navigationController?.navigationBar.isHidden = false
        
        tableView.register(ObjectTableViewCell.self, forCellReuseIdentifier: "titleCell")
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        navigationController?.topViewController?.title = "ONE"
        navigationController?.topViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshTableview(_:)))
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let _searchBar = searchController.searchBar
        if searchController.isActive && _searchBar.text != "" {
            guard let data = searchResultData else { return initialData.count }
            return data.count
        } else {
            return initialData.count
        }
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! ObjectTableViewCell
        
        let _searchBar = searchController.searchBar
        if searchController.isActive && _searchBar.text != "" {
            if let data = searchResultData {
                cell.textLabel?.text = data[indexPath.row]
            }
        }
        else {
            cell.textLabel?.text = initialData[indexPath.row]
        }
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - navigationController!.navigationBar.frame.size.height)
        
        layout.scrollDirection = .horizontal
        let collectionViewController = ImageCollectionViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(collectionViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - SearchResultsController
    
    func updateSearchResults(for searchController: UISearchController) {
        searchTitle(searchText: searchController.searchBar.text!)
    }
    
    func refreshTableview(_ sender: UIBarButtonItem) {
        tableView.reloadData()
    }
    
    func searchTitle(searchText: String, scope: String = "All") {
        searchResultData = initialData.filter { title in
        return title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }

    // MARK: - Restoration 
    
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        // сохранить состояние properties
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        // восстановить состояние properties
    }
    
}
