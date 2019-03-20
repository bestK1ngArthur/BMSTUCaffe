//
//  Dish.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

struct Dish {
    enum Category: String {
        case econom = "ЭКОНОМ ОБЕД"
        case dietary = "ДИЕТИЧЕСКИЕ БЛЮДА"
        case cold = "ХОЛОДНЫЕ ЗАКУСКИ"
        case first = "ПЕРВЫЕ БЛЮДА"
        case second = "ВТОРЫЕ БЛЮДА"
        case side = "ГАРНИРЫ"
        case sauce = "СОУСЫ / ХЛЕБ"
        case drink = "НАПИТКИ"
        case other
    }
    
    var id: Int
    var name: String
    var outlet: String
    var price: String
    var category: Category
    
    var categoryImage: UIImage? {
        
        switch category {
        case .econom:
            return UIImage(named: "CategoryEconom")
        case .dietary:
            return UIImage(named: "CategoryDietary")
        case .cold:
            return UIImage(named: "CategoryCold")
        case .first:
            return UIImage(named: "CategoryFirst")
        case .second:
            return UIImage(named: "CategorySecond")
        case .side:
            return UIImage(named: "CategorySide")
        case .sauce:
            return UIImage(named: "CategorySauce")
        case .drink:
            return UIImage(named: "CategoryDrink")
        case .other:
            return UIImage(named: "CategoryOther")
        }
    }
}
