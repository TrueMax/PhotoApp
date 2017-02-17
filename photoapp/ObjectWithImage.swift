//
//  ObjectWithImage.swift
//  photoapp
//
//  Created by Maxim on 17.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

import SQLite

struct ObjectWithImage {
    
    // это объект БД - модель данных со свойствами
    
    func configureDatabase () -> Connection? {
    
    var database: Connection?
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
        do {
            database = try Connection("\(path)/database.sqlite3")
            
            let id = Expression<Int64>("id")
            let title = Expression<String>("title")
            let imageURL = Expression<String>("imageURL")
            let objects = Table("objects")
            
            try database!.run(objects.create(block: { table in
                table.column(id)
                table.column(title)
                table.column(imageURL)
            }))
            
        } catch {
            print(error.localizedDescription)
        }
        return database
    }
}
