//
//  String+Path.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import Foundation

extension String {
    
    var firstUppercased: String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    func appendingPathComponent(_ component: String) -> String {
        return (self as NSString).appendingPathComponent(component)
    }
}
