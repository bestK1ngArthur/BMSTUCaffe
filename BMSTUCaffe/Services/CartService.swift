//
//  CartService.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 18/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import Foundation

class CartService {
    
    private let cartKey = "CartKey"
    
    func add(_ dish: Dish, for caffe: Caffe) {
        let cartValue = generateCartValue(dish: dish, caffe: caffe)
        
        if var cart = UserDefaults.standard.value(forKey: cartKey) as? [String] {
            cart.append(cartValue)
            UserDefaults.standard.setValue(cart, forKey: cartValue)
        } else {
            UserDefaults.standard.setValue([cartValue], forKey: cartValue)
        }
    }
    
    func remove(_ dish: Dish, for caffe: Caffe) {
        let cartValue = generateCartValue(dish: dish, caffe: caffe)
        
        guard var cart = UserDefaults.standard.value(forKey: cartKey) as? [String], let index = cart.firstIndex(of: cartValue) else {
            return
        }
        
        cart.remove(at: index)
        UserDefaults.standard.setValue(cart, forKey: cartValue)
    }
    
    private func generateCartValue(dish: Dish, caffe: Caffe) -> String {
        return "\(caffe.id)|\(dish.id)"
    }
}
