//
//  Interactor.swift
//  photoapp
//
//  Created by Maxim on 17.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

import Foundation
import SQLite

struct Interactor {
    
    let url = URL(string: "http://private-db05-jsontest111.apiary-mock.com/androids")
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    func connectToAPI() {
        
        let session = URLSession.shared
        
        guard let _url = url else { return }
        let request = URLRequest(url: _url)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in
            
            guard error == nil else {
                print("\(error.debugDescription)")
                return
            }
            
            guard let _response = response else { return }
            print("\(_response)")
            
            guard let _data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: _data, options: .allowFragments) as? Array<Any>
                
                if let _json = json {
                    self.parseArray(array: _json)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            
        })
        task.resume()
    }
    
    private func parseArray(array: Array<Any>) {
        
        let objects = Table("objects")
        let number = Expression<Int64>("number")
        let title = Expression<String>("title")
        let imageURL = Expression<String>("imageURL")
        let id = Expression<Int64>("id")
        
        do {
            let database = try Connection("\(path)/database.sqlite3")
            
            try database.run(objects.create(ifNotExists: true) { table in
                table.column(number, primaryKey: .autoincrement, check: number <= 30)
                table.column(id)
                table.column(title)
                table.column(imageURL)
            })
        } catch {
            print("ERROR CREATING TABLE")
        }
        
        for element in array {
            let _element = element as? Dictionary<String, Any>
            guard let _id = _element?["id"] as? Int else { return }
            print(_id)
            
            guard let _title = _element?["title"] as? String else { return }
            print(_title)
            
            guard let _imageURL = _element?["img"] as? String else { return }
            print(_imageURL)
            
            do {
                let database = try Connection("\(path)/database.sqlite3")
                try database.run(objects.insert(or: .replace,
                                                id <- Int64(_id), title <- _title, imageURL <- _imageURL
                ))
                print("OBJECTS INSERTED")
                
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func retrieveTitles() -> [Object] {
        
        var titles = [Object]()
        
        do {
            let database = try Connection("\(path)/database.sqlite3")
            print("SQLITE PATH - RETRIEVAL: \(path)")
            let objects = Table("objects")
            let number = Expression<Int64>("number")
            let id = Expression<Int64>("id")
            let title = Expression<String>("title")
            let imageURL = Expression<String>("imageURL")
            
            for object in try database.prepare(objects){
                let _obj = Object(number: object[number], id: object[id], title: object[title], urlString: object[imageURL])
                titles.append(_obj)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        guard titles.count > 0 else {
            print("EMPTY DATABASE")
            return []
        }
        
        return titles
    }
    
}
