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
    var nameLabel: UILabel!

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
        
        let rectForLabel = CGRect(x: imageView.frame.midX - imageView.frame.size.width/4 - 11, y: imageView.frame.minY, width: imageView.frame.size.width/2, height: 55)
        nameLabel = UILabel(frame: rectForLabel)
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "GillSans-Bold", size: 20)
        nameLabel.textColor = UIColor.red
        nameLabel.layer.cornerRadius = 12
        nameLabel.layer.borderWidth = 1
        nameLabel.layer.borderColor = UIColor.red.cgColor
        imageView.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("CANNOT INITIALIZE COLLECTIONVIEWCELL")
    }
}
