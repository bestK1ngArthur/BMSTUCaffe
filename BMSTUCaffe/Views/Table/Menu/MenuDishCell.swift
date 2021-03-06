//
//  MenuDishCell.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class MenuDishCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var outletLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var addButton: CoolButton!
    
    private var dish: Dish?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        addButton.imageTintColor = UIColor(rgb: 0xFFE74C)
        addButton.substrateColor = UIColor.black
    }

    func fillCell(dish: Dish) {
        self.dish = dish
        
        nameLabel.text = dish.name
        outletLabel.text = dish.outlet
        priceLabel.text = "\(dish.price)₽"
        categoryImageView.image = dish.categoryImage
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        if let dish = dish, let caffe = AppManager.shared.selectedCaffe {
            AppManager.shared.cart.add(dish, for: caffe)
        }
    }
}
