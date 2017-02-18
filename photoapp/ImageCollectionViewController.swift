//
//  ImageCollectionViewController.swift
//  photoapp
//
//  Created by Maxim on 17.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController {
    

    var dataSource: [Object]?
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView!.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = false
       
        collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.isPagingEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _index = selectedIndex {
            let indexpath = IndexPath(row: 0, section: _index)
            collectionView!.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
        }
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let _dataSource = dataSource else { return 5 }
        return _dataSource.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
    
        
        cell.backgroundColor = UIColor.cyan
        guard let _dataSource = dataSource else {
            cell.imageView.image = UIImage(named: "IMAG2665.jpg")
            return cell
        }
        let url = URL(string: _dataSource[indexPath.section].urlString)
        cell.imageView.sd_setImage(with: url!, placeholderImage: UIImage(named: "IMAG2665.jpg"))
        cell.nameLabel.text = _dataSource[indexPath.section].title
        
        return cell
    }

    
}
