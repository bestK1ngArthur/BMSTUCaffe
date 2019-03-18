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
    let cart = CartService()

    var selectedCaffe: Caffe?
    var selectedCart: Cart? {
        guard let caffe = selectedCaffe, let rawCart = cart.get(for: caffe) else {
            return nil
        }
        
        let dishes = rawCart.dishesIDs.compactMap { id -> Dish? in
            return menu.getDish(id, for: caffe)
        }
        
        return Cart(dishes: dishes, caffe: caffe)
    }
    
    init() {
        selectedCaffe = menu.getCaffes().first
    }
}
