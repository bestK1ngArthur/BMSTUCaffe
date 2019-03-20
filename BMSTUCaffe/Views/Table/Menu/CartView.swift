//
//  CartView.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class CartContainterView: UIView {
    
    @IBOutlet weak var cartView: CartView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
        // Add shadow
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Add round corners
        cartView.layer.masksToBounds = true
        cartView.layer.cornerRadius = 20
        cartView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func update(cart: Cart) {
        cartView.update(cart: cart)
    }
}

class CartView: UIView {

    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartImageViewContainer: UIView!
    
    @IBOutlet weak var dishesCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var outletLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cartImageViewContainer.backgroundColor = UIColor(rgb: 0xFFE74C)
        cartImageViewContainer.layer.cornerRadius = cartImageViewContainer.frame.height / 2
    }
    
    func update(cart: Cart) {
        dishesCountLabel.text = String(cart.dishes.count)
        priceLabel.text = "\(cart.price)₽"
        
        if let outlet = cart.maxOutletComponent {
            outletLabel.text = "\(outlet.value) \(outlet.name.rawValue)"
        }
    }
}
