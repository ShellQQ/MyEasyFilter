//
//  CategoryCollectionViewCell.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/16.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    var labelText: String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = labelText
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.label.textColor = .black
                self.backgroundView?.isHidden = true
                self.selectedBackgroundView?.isHidden = false
            }
            else {
                self.label.textColor = .white
                self.backgroundView?.isHidden = false
                self.selectedBackgroundView?.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundAllCorners(cornerRadius: 5)
        
        let backView = UIView(frame: self.bounds)
        backView.layer.addSublayer(backgroundLayer())
        backView.roundCorners(cornerRadius: 15, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        self.backgroundView = backView
        
        let selBackView = UIView(frame: self.bounds)
        selBackView.layer.addSublayer(selectedBackgroundLayer())
        selBackView.roundCorners(cornerRadius: 15, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        self.selectedBackgroundView = selBackView
    }

    func backgroundLayer() -> CAGradientLayer {
        let layer = CAGradientLayer()
        
        layer.type = .axial
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        layer.colors = [UIColor(red: 180, green: 180, blue: 180, alpha: 1).cgColor,
                        UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        
        return layer
    }
    
    func selectedBackgroundLayer() -> CAGradientLayer{
        let layer = CAGradientLayer()
        
        layer.type = .axial
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        layer.colors = [UIColor(red: 251, green: 229, blue: 154, alpha: 1).cgColor,
                        UIColor(red: 249, green: 164, blue: 140, alpha: 1).cgColor,
                        UIColor(red: 198, green: 147, blue: 194, alpha: 1).cgColor,
                        UIColor(red: 155, green: 215, blue: 223, alpha: 1).cgColor,
                        UIColor(red: 162, green: 211, blue: 162, alpha: 1).cgColor,
                        UIColor(red: 225, green: 237, blue: 201, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        
        return layer
    }

}
