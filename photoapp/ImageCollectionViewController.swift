//
//  ImageCollectionViewController.swift
//  photoapp
//
//  Created by Maxim on 17.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

// отображение title + image, horizontal scroll 

import UIKit
import SDWebImage

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController {
    
    let dataSource = ["IMAG2665.jpg", "IMAG2671.jpg", "IMAG2684.jpg", "IMAG2688.jpg", "IMAG2689.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView!.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = false
       
        self.collectionView!.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView!.isPagingEnabled = true
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 5 // кол-во объектов из таблицы 
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
    
        
        cell.backgroundColor = UIColor.blue
        cell.imageView.image = UIImage(named: dataSource[indexPath.section])
        
        return cell
    }

    
}
