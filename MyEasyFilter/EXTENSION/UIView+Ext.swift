//
//  UIView+Ext.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

extension UIView {
    
    // 設定特定的圓角
    //      - 左上角：layerMinXMinYCorner
    //      - 左下角：layerMinXMaxYCorner
    //      - 右上角：layerMaxXMinYCorner
    //      - 右下角：layerMaxXMaxYCorner
    func roundCorners(cornerRadius: CGFloat, corners: CACornerMask) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.maskedCorners = corners
    }
    
    func roundAllCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func addGradientLayer(frame: CGRect, startPoint: CGPoint = CGPoint(x: 0.5, y: 0.5)) {
        let layer = CAGradientLayer()
        
        layer.type = .radial
        //layer.frame = self.frame
        layer.frame = frame
        layer.colors = [UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1).cgColor,
                        UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor,
                        UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor]
        //layer.locations = [0, 0.75, 1]
        layer.startPoint = startPoint
        layer.endPoint = CGPoint(x: 1.5 , y: 1)
        /*if self.frame.height >= self.frame.width {
         layer.endPoint = CGPoint(x: self.frame.height / self.frame.width , y: 1)
         }
         else {
         layer.endPoint = CGPoint(x: 1, y: self.frame.width / self.frame.height)
         }*/
        
        self.layer.addSublayer(layer)
    }
    
    func viewController() -> UIViewController? {
        //        var parentResponder: UIResponder? = self.superview
        //        while true {
        //            guard let nextResponder = parentResponder?.next else { return nil }
        //            if let viewController = nextResponder as? UIViewController {
        //                return viewController
        //            }
        //            parentResponder = nextResponder
        //        }
        
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    
    func parentViewController() -> UIViewController? {
        var parentResponder: UIResponder? = self
        while true {
            guard let nextResponder = parentResponder?.next else { return nil }
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            parentResponder = nextResponder
        }
    }
}
