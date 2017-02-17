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
    let database = ObjectWithImage().configureDatabase()
    
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
        
        for element in array {
            let _element = element as? Dictionary<String, Any>
            guard let _id = _element?["id"] as? Int else { return }
                print(_id)
            
            guard let _title = _element?["title"] as? String else { return }
                print(_title)
            
            guard let _imageURL = _element?["img"] as? String else { return }
                print(_imageURL)
            
            do {
                let objects = Table("objects")
                let title = Expression<String>("title")
                let imageURL = Expression<String>("imageURL")
                let id = Expression<Int64>("id")

                try database!.run(objects.insert(
                    id <- Int64(_id), title <- _title, imageURL <- _imageURL
                ))
                
            } catch {
                print(error.localizedDescription)
            }

        }
    }
}
