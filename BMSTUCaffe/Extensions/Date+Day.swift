//
//  Date+Day.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import Foundation

extension Date {
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self).lowercased()
    }
}
