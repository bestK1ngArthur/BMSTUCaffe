//
//  CartGeneralCell.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 20/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class CartGeneralCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dishesCountLabel: UILabel!
    @IBOutlet weak var outletLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCell(cart: Cart) {
        dishesCountLabel.text = String(cart.dishes.count)
        priceLabel.text = "\(cart.price)₽"
        
        if let outlet = cart.maxOutletComponent {
            outletLabel.text = "\(outlet.value) \(outlet.name.rawValue)"
        }
    }
}
