//
//  MenuService.swift
//  BMSTUCaffe
//
//  Created by a.belkov on 17/03/2019.
//  Copyright © 2019 bestK1ng. All rights reserved.
//

import Foundation

class MenuService {

    typealias JSON = [String: Any]
    
    private enum CaffeKey: String {
        case id
        case name
        case company
        case menu
    }
    
    private enum DishKey: String {
        case id
        case name
        case outlet
        case price
        case category
    }
    
    private let jsonNames: [String]
    
    init() {
        
        // Get resources path
        guard let resourcesPath = Bundle.main.resourcePath else {
            jsonNames = []
            return
        }
        
        // Get caffes jsons filenames
        var caffeFileNames: [String] = []
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: resourcesPath)
            for file in files where file.contains("Caffe") && file.contains("json") {
                caffeFileNames.append(file.replacingOccurrences(of: ".json", with: ""))
            }
        } catch let error {
            print(error)
        }
        
        jsonNames = caffeFileNames
    }
    
    func getDishes(for caffe: Caffe) -> [Dish] {
    
        var dishes: [Dish] = []
        
        guard let json = getCaffeJSON(caffeID: caffe.id),
            let menuJSON = json[CaffeKey.menu.rawValue] as? JSON,
            let dishJSONs = menuJSON[Date().day] as? [JSON] else {
            return dishes
        }
    
        dishes = dishJSONs.compactMap({ json -> Dish? in
            
            guard let id = json[DishKey.id.rawValue] as? Int,
                let name = json[DishKey.name.rawValue] as? String,
                let outlet = json[DishKey.outlet.rawValue] as? String,
                let price = json[DishKey.price.rawValue] as? String,
                let rawCategory = json[DishKey.category.rawValue] as? String else {
                    return nil
            }
            
            let category = Dish.Category(rawValue: rawCategory) ?? .other

            return Dish(id: id, name: name, outlet: outlet, price: price, category: category)
        })
        
        return dishes
    }
    
    func getCaffes() -> [Caffe] {

        let caffes = getCaffesJSONs().compactMap { json -> Caffe? in
            
            guard let id = json[CaffeKey.id.rawValue] as? Int,
                let name = json[CaffeKey.name.rawValue] as? String,
                let company = json[CaffeKey.company.rawValue] as? String else {
                 return nil
            }
            
            return Caffe(id: id, name: name, company: company)
        }
        
        return caffes
    }
    
    // MARK: Private helpers
    
    private func getCaffesJSONs() -> [JSON] {
        
        var jsons: [JSON] = []
        for jsonName in jsonNames {
            guard let url = Bundle.main.url(forResource: jsonName, withExtension: "json") else { continue }
            
            do {
                let data = try Data(contentsOf: url)
                let dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                if let json = dict as? JSON {
                    jsons.append(json)
                }
                
            } catch let error {
                print(error)
            }
        }
        
        return jsons
    }
    
    private func getCaffeJSON(caffeID: Int) -> JSON? {
        let jsons = getCaffesJSONs()
        
        for json in jsons {
            if let id = json[CaffeKey.id.rawValue] as? Int, id == caffeID {
                return json
            }
        }
        
        return nil
    }
}
