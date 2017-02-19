//
//  HelperFile.swift
//  photoapp
//
//  Created by Maxim on 19.02.17.
//  Copyright © 2017 Maxim Abakumov. All rights reserved.
//

// в этот файл в енумы также можно было бы вынести стилистические константы для UI: цвета, формы, толщину линий и тд  

import Foundation

public enum restorationKeys: String {
    case rootNavigationController = "RootNavigationController"
    case imageCollectionViewController = "ImageCollectionViewControllerRestorationId"
    case titleTableViewController = "ObjectTableViewControllerRestorationId"
    
    case imageSelectedIndex
    case searchResultsData
}
