//
//  Cart.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 18/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import Foundation

struct Cart {
    var dishes: [Dish]
    var caffe: Caffe
    var price: String {
        var price = 0
        for dish in dishes {
            if let dishPrice = Int(dish.price) {
                price += dishPrice
            }
        }
        
        return String(price)
    }
}
