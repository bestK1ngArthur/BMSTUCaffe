//
//  CartService.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 18/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import Foundation

class CartService {
    
    static let notificationCartChanged = Notification.Name("NotificationCartChanged")
    
    typealias Cart = (caffeID: Int, dishesIDs: [Int])
    typealias CartValue = (caffeID: Int, dishID: Int)
    
    private let cartKey = "CartKey"
    private let separator = "|"
    
    func get(for caffe: Caffe) -> Cart? {
        guard let cartValues = UserDefaults.standard.value(forKey: cartKey) as? [String], !cartValues.isEmpty else {
            return nil
        }

        let dishesIDs: [Int] = cartValues.compactMap { string -> Int? in
            
            guard let cartValue = generateCartValue(from: string), cartValue.caffeID == caffe.id else {
                return nil
            }
            
            return cartValue.dishID
        }
        
        return (caffe.id, dishesIDs)
    }

    func add(_ dish: Dish, for caffe: Caffe) {
        let cartValue = generateString(from: (caffe.id, dish.id))

        if var cart = UserDefaults.standard.value(forKey: cartKey) as? [String] {
            cart.append(cartValue)
            UserDefaults.standard.setValue(cart, forKey: cartKey)
        } else {
            UserDefaults.standard.setValue([cartValue], forKey: cartKey)
        }
        
        if let cart = get(for: caffe) {
            postNotification(cart: cart)
        }
    }
    
    func remove(_ dish: Dish, for caffe: Caffe) {
        let cartValue = generateString(from: (caffe.id, dish.id))
        
        guard var cart = UserDefaults.standard.value(forKey: cartKey) as? [String], let index = cart.firstIndex(of: cartValue) else {
            return
        }
        
        cart.remove(at: index)
        UserDefaults.standard.setValue(cart, forKey: cartKey)
        
        if let cart = get(for: caffe) {
            postNotification(cart: cart)
        }
    }
    
    // MARK: Notifications
    
    private func postNotification(cart: Cart) {
        NotificationCenter.default.post(name: CartService.notificationCartChanged, object: cart)
    }
    
    // MARK: Private helpers
    
    private func generateString(from cartValue: CartValue) -> String {
        return "\(cartValue.caffeID)\(separator)\(cartValue.dishID)"
    }
    
    private func generateCartValue(from string: String) -> CartValue? {
        let components = string.components(separatedBy: separator)
        guard components.count > 1, let caffeID = Int(components[0]), let dishID = Int(components[1]) else {
            return nil
        }
        
        return (caffeID, dishID)
    }
}
