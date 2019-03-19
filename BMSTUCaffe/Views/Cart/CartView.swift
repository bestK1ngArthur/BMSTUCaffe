//
//  CartView.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class CartContainterView: UIView {
    
    private var cartView: CartView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let view = Bundle.main.loadNibNamed(String(describing: CartView.self), owner: self, options: nil)?.first as? CartView else {
            return
        }
        
        cartView = view
        self.addSubview(view)
        
        // Add shadow
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: -1)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        cartView?.layer.masksToBounds = true
        cartView?.layer.cornerRadius = 20
        cartView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cartView?.frame = self.bounds
    }
    
    func update(cart: Cart) {
        cartView?.update(cart: cart)
    }
}

class CartView: UIView {

    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartImageViewContainer: UIView!
    
    @IBOutlet weak var dishesCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cartImageViewContainer.backgroundColor = UIColor(rgb: 0xFFE74C)
        cartImageViewContainer.layer.cornerRadius = cartImageViewContainer.frame.height / 2
    }
    
    func update(cart: Cart) {
        dishesCountLabel.text = String(cart.dishes.count)
        priceLabel.text = "\(cart.price)₽"
    }
}
