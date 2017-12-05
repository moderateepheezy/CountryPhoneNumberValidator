//
//  Country.swift
//  PhoneNumberPicker
//
//  Created by SimpuMind on 11/7/17.
//  Copyright © 2017 SimpuMind. All rights reserved.
//

import Foundation

public class Country {
    
    var name = String()
    var iso2 = String()
    var dialCode = String()
    var priority = Int()
    var areaCodes: [String]?
    var flag = String()
    
    init(value: [String : Any]) {
        name = value["name"] as? String ?? ""
        iso2 = value["iso2"] as? String ?? ""
        dialCode = value["dialCode"] as? String ?? ""
        priority = value["priority"] as? Int ?? 0
        areaCodes = value["areaCodes"] as? [String] ?? []
        flag = value["flag"] as? String ?? ""
    }
    
    static func loadCountryFromJson() -> [Country]{
        var countries = [Country]()
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: Any]] {
                    for dictionary in jsonResult{
                        countries.append(Country(value: dictionary))
                    }
                }
            }catch{
                print("Invalid filename/path.")
            }
        }
        return countries
    }
}


