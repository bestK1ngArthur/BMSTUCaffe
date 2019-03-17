//
//  MenuViewController.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    struct Section {
        var name: String
        var dishes: [Dish]
    }
    
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        
        if let sections = constructSections() {
            self.sections = sections
        } else {
            // TODO: Show empty screen
        }
    }
    
    private func constructSections() -> [Section]? {
        
        guard let caffe = AppManager.shared.selectedCaffe else {
            return nil
        }
        
        var sections: [Section] = []
        let dishes = AppManager.shared.menu.getDishes(for: caffe)
        
        // My mega bad alghorhytm to split dishes to sections ;)

        var currentSection: Dish.Category?
        var currentSectionDishes: [Dish] = []
        for dish in dishes {
            
            if let category = currentSection {
                
                // If new section
                if category != dish.category {
                    sections.append(Section(name: category.rawValue, dishes: currentSectionDishes))
                    
                    // Clear section vars
                    currentSection = dish.category
                    currentSectionDishes = []
                }
            } else {
                currentSection = dish.category
            }

            guard let sectionName = currentSection else { continue }
    
            if dish.category == sectionName {
                currentSectionDishes.append(dish)
            }
        }
        
        sections.append(Section(name: currentSection!.rawValue, dishes: currentSectionDishes))

        return sections
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].dishes.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DishCell.self)) as? DishCell else {
            return UITableViewCell()
        }
        
        cell.fillCell(dish: sections[indexPath.section].dishes[indexPath.row])
        
        return cell
    }
}

