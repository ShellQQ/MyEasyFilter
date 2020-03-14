//
//  AttributeCollectionViewCell.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/16.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class AttributeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
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
        // Initialization code
        self.roundAllCorners(cornerRadius: 5)
        
        let backView = UIView(frame: self.bounds)
        backView.backgroundColor = .white
        backView.alpha = 0.2
        self.backgroundView = backView
        
        let selBackView = UIView(frame: self.bounds)
        selBackView.layer.addSublayer(selectedBackgroundLayer())
        self.selectedBackgroundView = selBackView
    }
    
    func selectedBackgroundLayer() -> CAGradientLayer{
        let layer = CAGradientLayer()
        
        layer.type = .axial
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        layer.colors = [UIColor(red: 250, green: 163, blue: 43, alpha: 1).cgColor,
                        UIColor(red: 248, green: 203, blue: 113, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        
        //self.layer.addSublayer(layer)
        return layer
    }
    
    func disableCell(isDisable: Bool) {
        if isDisable {
            self.label.textColor = .gray
            self.backgroundView!.alpha = 0.1
            self.isUserInteractionEnabled = false
        }
        else {
            self.label.textColor = .white
            self.backgroundView!.alpha = 0.2
            self.isUserInteractionEnabled = true
        }
    }
    
    
}
