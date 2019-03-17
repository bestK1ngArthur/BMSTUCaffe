//
//  AppManager.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import Foundation

class AppManager {

    static let shared = AppManager()
    
    let menu = MenuService()
    
    var selectedCaffe: Caffe?
    
    init() {
        selectedCaffe = menu.getCaffes().first
    }
}
