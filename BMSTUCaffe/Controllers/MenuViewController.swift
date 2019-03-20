//
//  MenuViewController.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    struct Section {
        var name: String
        var dishes: [Dish]
    }
    
    var cartViewCanUpdate = true
    
    var sections: [Section] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cartContainer: CartContainterView!
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartView(notification:)), name: CartService.notificationCartChanged, object: nil)
        
        updateCartView()
    }
        
    private func initUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: cartContainer.bounds.height, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: cartContainer.bounds.height, right: 0)
        
        addCartView()
        
        if let sections = constructSections(), sections.count > 0 {
            self.sections = sections
        } else {
            emptyView.isHidden = false
            cartContainer.alpha = 0
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
        
        if let currentSection = currentSection {
            sections.append(Section(name: currentSection.rawValue, dishes: currentSectionDishes))
        }

        return sections
    }
    
    // MARK: CartView
    
    private func addCartView() {
        self.cartContainer.alpha = 0
        
        // Add tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(cartViewTapped))
        cartContainer.addGestureRecognizer(tap)
    }
    
    func showCartView() {
        
        UIView.animate(withDuration: 0.3) {
            self.cartContainer.alpha = 1
        }
        
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: cartContainer.bounds.height, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: cartContainer.bounds.height, right: 0)
    }
    
    func hideCartView() {

        UIView.animate(withDuration: 0.3) {
            self.cartContainer.alpha = 0
        }
        
        tableView.contentInset = UIEdgeInsets.zero
        tableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func updateCartView(notification: Notification? = nil) {
        guard cartViewCanUpdate else { return }

        guard let cart = AppManager.shared.selectedCart, cart.dishes.count > 0 else {
            hideCartView()
            return
        }
        
        showCartView()
        cartContainer.update(cart: cart)
    }
    
    @objc private func cartViewTapped() {
        
        guard let destionation = storyboard?.instantiateViewController(withIdentifier: "NavigationCartViewController") else {
            return
        }

        let segue = ShowCartSegue(identifier: ShowCartSegue.identifier, source: self, destination: destionation)
        self.prepare(for: segue, sender: self)
        segue.perform()
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].dishes.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tableHeader = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuHeader.self)) as? MenuHeader else {
            return UIView()
        }
        
        tableHeader.nameLabel.text = sections[section].name.firstUppercased
        
        return tableHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuDishCell.self)) as? MenuDishCell else {
            return UITableViewCell()
        }
        
        cell.fillCell(dish: sections[indexPath.section].dishes[indexPath.row])
        
        return cell
    }
}

