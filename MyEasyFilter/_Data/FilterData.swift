//
//  FilterData.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import CoreImage

class FilterData {
    static let data = FilterData()
    
    var saveFilters: Array<Dictionary<String, Any>> = []
    
    func addFilterToList(categoryName: String, filterName: String) {
        
        // 儲存已選濾鏡參數
        let filter = CIFilter(name: filterName)
        let attributes = filter!.attributes
        let inputKeys = filter!.inputKeys
        var attributeList = Array<Dictionary<String, Any>>()
        
        for key in inputKeys {
            
            let attribute = attributes[key] as? [String : AnyObject]
            
            guard let className = attribute?[kCIAttributeClass] else {  return  }
            
            let defaultValue = attribute?[kCIAttributeDefault]
            
            attributeList.append(["key": key, "className": className, "value": defaultValue as Any])
        }
        
        saveFilters.append(["category": categoryName, "filter": filterName, "saveValues": attributeList, "isOn": true])
        
        // 將已選取濾鏡依照字母順序排序
        let sort = saveFilters.sorted {
            // 先排 categoryName
            guard let s1 = $0["category"] as? String, let s2 = $1["category"] as? String else {
                return false
            }
            
            // 再排 filterName
            if s1 == s2 {
                guard let g1 = $0["filter"] as? String, let g2 = $1["filter"] as? String else {
                    return false
                }
                return g1 < g2
            }
            
            return s1 < s2}
        
        saveFilters = sort
        
        print("")
        print("after add filter")
        listSaveFilters()
    }
    
    func removeFilterFromList(filterName: String) {
        for (index, item) in saveFilters.enumerated() {
            if item["filter"] as! String == filterName {
                saveFilters.remove(at: index)
            }
        }
        
        print("")
        print("remove complete")
        listSaveFilters()
    }
    
    func isInFilterList(filterName: String) -> Bool {
        for item in saveFilters {
            if item["filter"] as! String == filterName {
                return true
            }
        }
        
        return false
    }
    
    func listSaveFilters(){
        for item in saveFilters {
            print("  \(item["category"]!), \(item["filter"]!)")
        }
    }
}
