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
        
        let rect = CGRect(x: contentView.frame.minX + 22, y: contentView.frame.minY + 33, width: contentView.frame.width - 44, height: contentView.frame.height - 66)
        imageView = UIImageView(frame: rect)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        contentView.backgroundColor = UIColor.clear
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CANNOT INITIALIZE COLLECTIONVIEWCELL")
    }
}
