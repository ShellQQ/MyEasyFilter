//
//  FilterData.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Nautilus. All rights reserved.
import CoreImage
import UIKit

struct FilterAttribute {
    var className: String
    var value: Any?
    var minValue: Float?
    var maxValue: Float?
}

struct FilterInfo {
    var filterName: String
    var filterDisplayName: String
    var filterDiscription: String
    var filterCategory: String
    var iosVersion: String
    var macVersion: String
    var reference: String
    var attributes: Array<FilterAttributeInfo>
}

struct FilterAttributeInfo {
    var attributeName: String
    var className: String
    var description: String
    var attributeRange: String
}

class FilterData {
    static let data = FilterData()
    
    var saveData: Dictionary<String, Dictionary<String, Dictionary<String, FilterAttribute>>> = [:]
    //var saveFilters: Dictionary<String, Dictionary<String, FilterAttribute>> = [:]
    //var saveAttributes: Dictionary<String, FilterAttribute> = [:]
    
    //var saveFilters: Array<Dictionary<String, Any>> = []
    
    var selectedCategory: String = ""
    var selectedFilter: String = ""
    var selectedAttribute: String = ""
    
    let categoriesList = [kCICategoryBlur, kCICategoryColorAdjustment, kCICategoryColorEffect, kCICategoryCompositeOperation, kCICategoryDistortionEffect, kCICategoryGenerator, kCICategoryGeometryAdjustment, kCICategoryGradient, kCICategoryHalftoneEffect, kCICategoryReduction, kCICategorySharpen, kCICategoryStylize, kCICategoryTileEffect, kCICategoryTransition]
    
    let discareFilters: Dictionary<String, Array<String>> =
        [kCICategoryBlur: ["CIDepthBlurEffect"],
         kCICategoryColorAdjustment: [],
         kCICategoryColorEffect: ["CIColorCube", "CIColorCubeWithColorSpace", "CIColorCubesMixedWithMask", "CIColorCurves", "CIPalettize"],
         kCICategoryCompositeOperation: ["CISourceInCompositing", "CISourceOutCompositing", "CISourceOverCompositing"],
         kCICategoryDistortionEffect: ["CICameraCalibrationLensCorrection"],
         kCICategoryGenerator: ["CIAttributedTextImageGenerator", "CIAztecCodeGenerator", "CIBarcodeGenerator", "CICheckerboardGenerator", "CICode128BarcodeGenerator", "CIConstantColorGenerator", "CILenticularHaloGenerator", "CIMeshGenerator", "CIPDF417BarcodeGenerator", "CIQRCodeGenerator", "CIRandomGenerator", "CIStarShineGenerator", "CIStripesGenerator", "CISunbeamsGenerator", "CITextImageGenerator"],
         kCICategoryGeometryAdjustment: ["CIAffineTransform"],
         kCICategoryGradient: ["CIHueSaturationValueGradient"],
         kCICategoryHalftoneEffect: [],
         kCICategoryReduction: [],
         kCICategorySharpen: [],
         kCICategoryStylize: ["CICoreMLModelFilter"],
         kCICategoryTileEffect: [],
         kCICategoryTransition: []]
    
    // 將所選濾鏡儲存
    func addFilterToList() {
        let filter = CIFilter(name: selectedFilter)
        let attributes = filter!.attributes
        let inputKeys = filter!.inputKeys
        
        var saveAttributes = Dictionary<String, FilterAttribute>()
        
        for key in inputKeys {

            let attribute = attributes[key] as? [String : AnyObject]
            // Class類型
            let className = attribute![kCIAttributeClass] as! String
            // attribute default 值
            let defaultValue = attribute?[kCIAttributeDefault]
            // key的說明
            //let description = attribute?[kCIAttributeDescription] as? String
            // key Slider Max
            let sliderMax = (attribute?[kCIAttributeMax] as? NSNumber)?.floatValue
            // key Slider Min
            let sliderMin = (attribute?[kCIAttributeMin] as? NSNumber)?.floatValue

            saveAttributes[key] = FilterAttribute(className: className, value: defaultValue, minValue: sliderMin, maxValue: sliderMax)
            //print("attribute \(String(describing: attribute))")
        }
        
        var saveFilters = Dictionary<String, Dictionary<String, FilterAttribute>>()
        
        if let filters = saveData[selectedCategory]  {
            saveFilters = filters
        }
        
        saveFilters[selectedFilter] = saveAttributes
        saveData[selectedCategory] = saveFilters
    }
    
    // 移除儲存濾鏡
    func removeFilterFromList() {
        guard let _ = saveData[selectedCategory] else { return }
        
        saveData[selectedCategory]![selectedFilter] = nil
    }
    
    // 取得濾鏡參數值
    func getSelectedAttributeValue() -> FilterAttribute? {
        if let attribute = saveData[selectedCategory]?[selectedFilter] {
            return attribute[selectedAttribute]
        }
        return nil
    }
    
    // 更改濾鏡參數值
    func changeSelectedAttributeValue(value: Any) {
        if saveData[selectedCategory]?[selectedFilter] != nil {
            saveData[selectedCategory]![selectedFilter]![selectedAttribute]?.value = value
        }
    }
    
    // 檢查濾鏡是否已在儲存列表
    func isSave(filterName: String) -> Bool {
        if saveData[selectedCategory]?[filterName] != nil { return true }

        return false
    }
    
    // 得到濾鏡資訊，以顯示在 Info Page
    func getFilterInfo(filterName: String) -> FilterInfo? {
        guard let filter = CIFilter(name: "CIBokehBlur") else { return nil}
    
        let attributes = filter.attributes
        let inputKeys = filter.inputKeys
        
        let filterDispalyName = attributes[kCIAttributeFilterDisplayName] as! String
        let description = attributes[kCIAttributeDescription] as! String
        let categories = attributes[kCIAttributeFilterCategories] as! String
        let ios = attributes[kCIAttributeFilterAvailable_iOS] as! String
        let mac = attributes[kCIAttributeFilterAvailable_Mac] as! String
        let reference = attributes[kCIAttributeReferenceDocumentation] as! String
        var attributeList = Array<FilterAttributeInfo>()
        
        for key in inputKeys {
            let attribute = attributes[key] as? [String : AnyObject]
            
            // Class類型
            let className = attribute?[kCIAttributeClass] as! String
            // key的說明
            let description = attribute?[kCIAttributeDescription] as! String
            // key Slider Min
            let sliderMin = (attribute?[kCIAttributeMin] as? NSNumber)!.stringValue
            // key Slider Max
            let sliderMax = (attribute?[kCIAttributeMax] as? NSNumber)!.stringValue
            
            attributeList.append(FilterAttributeInfo(attributeName: key, className: className, description: description, attributeRange: "Min: \(sliderMin) to Max: \(sliderMax)"))
        }
        
        return FilterInfo(filterName: filterName, filterDisplayName: filterDispalyName, filterDiscription: description, filterCategory: categories, iosVersion: ios, macVersion: mac, reference: reference, attributes: attributeList)
    }
    
    func isDiscare(filterName: String) -> Bool {
        guard let discare = discareFilters[selectedCategory] else { return false }
        
        for name in discare {
            if filterName == name {
                return true
            }
        }
        return false
    }
    
    func getCategoryNameByIndex(index: Int) -> String {
        selectedCategory = categoriesList[index]
        return selectedCategory
    }
    
    func applyAllFilters(image: UIImage) -> UIImage {
        var outputImage = image
        
        for filters in saveData {
            for filter in filters.value {
                //print(filter.key)
                //print(filter.value)
                outputImage = image.applyFilter(filterName: filter.key, attributes: filter.value)
            }
        }
        return outputImage
    }
    
    /*// 將濾鏡存在列表中並依 CategoryName -> FilterName 排序
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
        
        //print("")
        //print("after add filter")
        //listSaveFilters()
    }
    
    // 從儲存列表中刪除濾鏡
    func removeFilterFromList(filterName: String) {
        for (index, item) in saveFilters.enumerated() {
            if item["filter"] as! String == filterName {
                saveFilters.remove(at: index)
            }
        }
        
        //print("")
        //print("remove complete")
        //listSaveFilters()
    }
    
    func changeFilterAttributeValue(value: Any) {
        
        for (indexF, item) in saveFilters.enumerated() {
            if item["filter"] as! String == selectedFilterName {
            
                var attrList = item["saveValues"] as! Array<Dictionary<String, Any>>
            
                for (indexA, attr) in attrList.enumerated() {
                    
                    if attr["key"] as! String == selectedAttributeName {
                        attrList[indexA]["value"] = value
                        saveFilters[indexF]["saveValues"] = attrList
                    }
                }
            }
        }
    }
    
    func getFilterAttributeValue() -> String {
        for item in saveFilters {
            if item["filter"] as! String == selectedFilterName {
                
                let attrList = item["saveValues"] as! Array<Dictionary<String, Any>>
                
                for attr in attrList {
                    if attr["key"] as! String == selectedAttributeName {
                        
                        let classname = attr["className"] as! String
                        
                        if classname == "NSNumber" {
                            //let value = (attr["value"]! as! NSNumber).floatValue
                            return (attr["value"]! as! NSNumber).stringValue
                        }
                        else if classname == "CIVector" {
                            return String(reflecting: attr["value"]! as! NSNumber)
                        }
                    }
                }
            }
        }
        return ""
    }
    
     // 濾鏡是否已儲存在列表內
     func isInFilterList(filterName: String) -> Bool {
     for item in saveFilters {
     if item["filter"] as! String == filterName {
     return true
     }
     }
     
     return false
     }
     */
    
    // 濾鏡是否可選取
    
}
