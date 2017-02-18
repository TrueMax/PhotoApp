//
//  ImageCollectionViewCell.swift
//  photoapp
//
//  Created by Maxim on 18.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let rect = CGRect(x: 10, y: 10, width: contentView.bounds.width - 20, height: contentView.bounds.height - 10)
        imageView = UIImageView(frame: rect)
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CANNOT INITIALIZE COLLECTIONVIEWCELL")
    }
}
