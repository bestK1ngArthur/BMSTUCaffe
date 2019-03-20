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
    
    var outletComponents: [OutletComponent] {
        var gramms: Int = 0
        var millimeters: Int = 0
        
        dishes.forEach { dish in
            dish.outletComponents.forEach({ (name: ComponentName, value: Int) in
                
                switch name {
                case .grams:
                    gramms += value
                case .milliliters:
                    millimeters += value
                }
            })
        }
        
        return [(name: ComponentName.grams, value: gramms), (name: ComponentName.milliliters, value: millimeters)]
    }
    
    var maxOutletComponent: OutletComponent? {
        
        let sorted = outletComponents.sorted { (first, second) -> Bool in
            return first.value > second.value
        }
        
        return sorted.first
    }
}
