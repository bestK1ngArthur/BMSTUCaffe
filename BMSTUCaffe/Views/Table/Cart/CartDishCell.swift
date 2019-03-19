//
//  CartDishCell.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 19/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class CartDishCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var outletLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillCell(dish: Dish) {
        nameLabel.text = dish.name
        outletLabel.text = dish.outlet
        priceLabel.text = "\(dish.price)₽"
    }
}
