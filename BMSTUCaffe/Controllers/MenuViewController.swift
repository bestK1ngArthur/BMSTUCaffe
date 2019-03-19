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
    
    let cartViewHeight: CGFloat = 83
    var cartViewCanUpdate = true
    
    var sections: [Section] = []

    var cartContainer: CartContainterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addCartView()
        updateCartView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartView(notification:)), name: CartService.notificationCartChanged, object: nil)
        
        initUI()
    }
        
    private func initUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: cartViewHeight, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: cartViewHeight, right: 0)
        
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
    
    // MARK: CartView
    
    private func addCartView() {
        
        let y: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height - cartViewHeight
        let frame = CGRect(x: 0, y: y, width: view.bounds.width, height: cartViewHeight)
        let cartView = CartContainterView(frame: frame)

        UIApplication.shared.keyWindow?.addSubview(cartView)
        
        self.cartContainer = cartView
        self.cartContainer.alpha = 0
        
        // Add tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(cartViewTapped))
        cartView.addGestureRecognizer(tap)
    }
    
    func showCartView() {
        
        UIView.animate(withDuration: 0.3) {
            self.cartContainer.alpha = 1
        }
    }
    
    func hideCartView() {

        UIView.animate(withDuration: 0.3) {
            self.cartContainer.alpha = 0
        }
    }
    
    @objc func updateCartView(notification: Notification? = nil) {
        guard cartViewCanUpdate else { return }
        
        guard let cart = AppManager.shared.selectedCart else {
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
    
    // MARK: Table view

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].dishes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let tableHeader = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuHeader.self)) as? MenuHeader else {
            return UIView()
        }
        
        tableHeader.nameLabel.text = sections[section].name.firstUppercased
        
        return tableHeader
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MenuDishCell.self)) as? MenuDishCell else {
            return UITableViewCell()
        }
        
        cell.fillCell(dish: sections[indexPath.section].dishes[indexPath.row])
        
        return cell
    }
}

