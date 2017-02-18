//
//  Object.swift
//  photoapp
//
//  Created by Maxim on 18.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

import Foundation

struct Object {
    
    var number: Int64 = 0
    var id: Int64 = 0
    var title: String = ""
    var urlString: String = ""
    
    init(number: Int64, id: Int64, title: String, urlString: String) {
        self.number = number
        self.id = id
        self.title = title
        self.urlString = urlString
    }
}
