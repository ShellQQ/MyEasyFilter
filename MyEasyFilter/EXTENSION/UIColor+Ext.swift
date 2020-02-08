//
//  UIColor+Ext.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let redValue = CGFloat(red) / 255
        let greenValue = CGFloat(green) / 255
        let blueValue = CGFloat(blue) / 255
        
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alpha)
    }
}
