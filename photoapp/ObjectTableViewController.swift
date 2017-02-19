//
//  ObjectTableViewController.swift
//  photoapp
//
//  Created by Maxim on 17.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//


import UIKit

class ObjectTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    
    var searchController = UISearchController(searchResultsController: nil)
    var searchHeaderView: UIView!
    var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var searchResultData: [String]?
    var initialTitles = ["ONE", "TWO", "THREE", "FOUR", "FIVE"] {
        didSet {
            tableView.reloadData()
        }
    }
    var dataSource: [Object]?
    
    var navigationTitle: String = "СПИСОК" {
        didSet {
            navigationController?.topViewController?.title = navigationTitle
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restorationIdentifier = restorationKeys.titleTableViewController.rawValue
        restorationClass = ObjectTableViewController.self
        
        self.view.backgroundColor = UIColor.white
        
        searchHeaderView = UIView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: self.view.frame.width, height: 44))
        tableView = UITableView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: self.view.frame.width, height: self.view.frame.height - ((navigationController?.navigationBar.frame.size.height)!+22)))
        self.view.addSubview(searchHeaderView)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = UIColor.cyan
        self.view.sendSubview(toBack: tableView)
        tableView.register(ObjectTableViewCell.self, forCellReuseIdentifier: "titleCell")
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.refreshTableview(_:)), for: .valueChanged)
        
        configureSearchController()
        
        dataSource = Interactor().retrieveTitles()
        if let data = dataSource {
            initialTitles = data.map({$0.title})
        }
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        searchController.searchBar.barStyle = UIBarStyle.black
        searchController.searchBar.barTintColor = UIColor.white
        searchController.searchBar.backgroundColor = UIColor.clear
        
        searchHeaderView.addSubview(searchController.searchBar)
        searchController.searchBar.sizeToFit()
        searchController.searchBar.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        
            }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.topViewController?.title = navigationTitle
        navigationController?.topViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshTableview(_:)))
        
        UIView.animate(withDuration: 0.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            self.tableView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
            
            
        }, completion: { (true) in
            
            UIView.animate(withDuration: 3, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.tableView.transform = CGAffineTransform(translationX: 0, y: 0)
                
                
            }, completion: {(true) in
                let data = Interactor().retrieveTitles()
                if data.count > 0 {
                    self.initialTitles = data.map({$0.title})
                    self.tableView.reloadData()
                }
            })
        })

        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let _searchBar = searchController.searchBar
        if searchController.isActive && _searchBar.text != "" {
            guard let data = searchResultData else { return initialTitles.count }
            return data.count
        } else {
            return initialTitles.count
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
            cell.textLabel?.text = initialTitles[indexPath.row]
        }
        return cell
    }
    
    // MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - navigationController!.navigationBar.frame.size.height)
        
        layout.scrollDirection = .horizontal
        let collectionViewController = ImageCollectionViewController(collectionViewLayout: layout)
        if let data = dataSource {
            collectionViewController.dataSource = data
            collectionViewController.selectedIndex = indexPath.row
        }
        
        
        navigationController?.pushViewController(collectionViewController, animated: true)
        searchController.dismiss(animated: false, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - SearchResultsController
    
    func updateSearchResults(for searchController: UISearchController) {
        searchTitle(searchText: searchController.searchBar.text!)
    }
    
    func refreshTableview(_ sender: UIBarButtonItem) {
        
        refreshControl.beginRefreshing()
        searchResultData = nil
        searchController.dismiss(animated: true, completion: nil)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func searchTitle(searchText: String) {
        searchResultData = initialTitles.filter { title in
            return title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    // MARK: - Restoration
    
    override func encodeRestorableState(with coder: NSCoder) {
        
        if let searchData = searchResultData {
            coder.encode(searchData, forKey: restorationKeys.searchResultsData.rawValue)
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        
        if let data = coder.decodeObject(forKey: restorationKeys.searchResultsData.rawValue) as! [String]? {
            searchResultData = data
        }
        
        super.decodeRestorableState(with: coder)
    }
    
    
    // MARK - Alert

    func alertAccessError() {
        let controller = UIAlertController(title: "ERROR", message: "Error connecting to SQLite database", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Try again later", style: .cancel, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
}

extension ObjectTableViewController: UIViewControllerRestoration {
    @available(iOS 2.0, *)
    public static func viewController(withRestorationIdentifierPath identifierComponents: [Any], coder: NSCoder) -> UIViewController? {
        return ObjectTableViewController()
    }
}
