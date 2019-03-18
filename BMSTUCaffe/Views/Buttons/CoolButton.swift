//
//  CoolButton.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import UIKit

class CoolButton: UIButton {
    
    var substrateColor: UIColor?
    var imageTintColor: UIColor? {
        didSet {
            guard let imageTintColor = imageTintColor, let image = self.backgroundImage(for: .normal) else {
                return
            }
            
            self.setBackgroundImage(image.withColor(imageTintColor), for: .normal)
        }
    }
    
    private let substrateInset: CGFloat = 5
    private let substrateTag = 1010

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubstrateView()
    }
    
    private func addSubstrateView() {
        subviews.forEach { subview in
            if subview.tag == substrateTag {
                subview.removeFromSuperview()
            }
        }
        
        guard let substrateColor = substrateColor else {
            return
        }
        
        let frame = CGRect(x: substrateInset / 2,
                           y: substrateInset / 2,
                           width: self.frame.width - substrateInset,
                           height: self.frame.height - substrateInset)
        let substrate = UIView(frame: frame)
        substrate.backgroundColor = substrateColor
        substrate.layer.cornerRadius = frame.height / 2
        substrate.tag = substrateTag
        substrate.isUserInteractionEnabled = false
        self.addSubview(substrate)
        self.sendSubviewToBack(substrate)
    }
}
