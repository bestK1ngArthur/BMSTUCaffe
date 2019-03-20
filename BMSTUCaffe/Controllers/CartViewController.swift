//
//  CartViewController.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    let clearButtonHeight: CGFloat = 40 + 50 + 16
    
    @IBOutlet weak var tableView: UITableView!
    
    var cart: Cart?
    
    var darkView: UIView? {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(close))
            darkView?.addGestureRecognizer(tap)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCart(notification:)), name: CartService.notificationCartChanged, object: nil)
        updateCart()
        
        initUI()
    }
    
    func initUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: clearButtonHeight, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: clearButtonHeight, right: 0)
    }
    
    @objc private func updateCart(notification: Notification? = nil) {
        
        cart = AppManager.shared.selectedCart
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
        if let caffe = AppManager.shared.selectedCaffe {
            AppManager.shared.cart.removeAll(for: caffe)
        }
        
        close()
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cart?.dishes.count ?? -1) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cart = cart, indexPath.row == cart.dishes.count,
         let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartGeneralCell.self)) as? CartGeneralCell {
            cell.fillCell(cart: cart)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CartDishCell.self)) as? CartDishCell,
            let dish = cart?.dishes[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.fillCell(dish: dish)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete,
            let dish = cart?.dishes[indexPath.row],
            let caffe = AppManager.shared.selectedCaffe else {
                return
        }
        
        // FIXME: Fix remove animation
//        tableView.beginUpdates()
        AppManager.shared.cart.remove(dish, for: caffe)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        tableView.endUpdates()
    }
}
