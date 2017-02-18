//
//  ObjectTableViewCell.swift
//  photoapp
//
//  Created by Maxim on 18.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

import UIKit

class ObjectTableViewCell: UITableViewCell {
    
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "titleCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
