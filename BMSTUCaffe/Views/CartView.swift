//
//  CartView.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class CartView: UIView {

    private var contentView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        guard let view = Bundle.main.loadNibNamed(String(describing: CartView.self), owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        contentView = view
        self.addSubview(view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let view = Bundle.main.loadNibNamed(String(describing: CartView.self), owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        contentView = view
        self.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView?.frame = self.bounds
    }
}
