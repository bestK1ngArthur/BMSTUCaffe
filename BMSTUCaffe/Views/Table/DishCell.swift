//
//  DishCell.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class DishCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var outletLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addButton: CoolButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        addButton.imageTintColor = UIColor(rgb: 0xFFE74C)
        addButton.substrateColor = UIColor.black
    }

    func fillCell(dish: Dish) {
        nameLabel.text = dish.name
        outletLabel.text = dish.outlet
        priceLabel.text = "\(dish.price)₽"
    }
}
