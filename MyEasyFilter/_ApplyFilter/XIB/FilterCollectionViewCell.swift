//
//  FilterCollectionViewCell.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/16.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
   
    var categoryName: String = ""
    var filterName: String = ""
    
    weak var delegate: AddOrRemoveFilterDelegate?

    @IBOutlet weak var label: UILabel!
    
    var labelText: String {
        get {
            return label.text ?? ""
        }
        set {
            label.text = newValue
            
            self.isSelected = false
            self.backgroundView = backView()
            self.selectedBackgroundView = backViewWithBorder()
            
            addOrRemoveButton.isSelected = false
            addOrRemoveButton.isEnabled = true
        }
    }
    
    lazy var addOrRemoveButton: UIButton = {
        // 設定按鈕 normal 狀態
        let button = TemplateButton(imageName: "add", size: CGSize(width: 22, height: 22))
        
        // 設定按鈕 isSelected 狀態
        button.setSelectImage(imageName: "remove", backgroundColor: .red, size: CGSize(width: 22, height: 22))
        
        button.addTarget(self, action: #selector(addOrRemoveTap(_:)), for: .touchUpInside)
        
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.roundAllCorners(cornerRadius: 5)
        
        self.backgroundView = backView()
        self.selectedBackgroundView = backViewWithBorder()
        
        // addOrRemoveButton 初始設定
        self.addSubview(addOrRemoveButton)
        
        addOrRemoveButton.translatesAutoresizingMaskIntoConstraints = false
        addOrRemoveButton.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        addOrRemoveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
    }
    
    @objc func addOrRemoveTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        if sender.isSelected {
            self.backgroundView = selectedBackView()
            self.selectedBackgroundView = selectedBackViewWithBorder()
            delegate?.addFilter(categoryName: categoryName, filterName: filterName)
        }
        else {
            self.backgroundView = backView()
            self.selectedBackgroundView = backViewWithBorder()
            delegate?.removeFilter(filterName: filterName)
        }
    }
    
    func cellIsSelected() {
        addOrRemoveButton.isSelected = true
        self.backgroundView = selectedBackView()
        self.selectedBackgroundView = selectedBackViewWithBorder()
    }
    
    func disableAddOrRemoveButton() {
        addOrRemoveButton.isEnabled = false
    }
    
    /*func resetCell() {
        self.isSelected = false
        self.backgroundView = backView()
        self.selectedBackgroundView = backViewWithBorder()
        
        addOrRemoveButton.isSelected = false
    }*/
    
    func backView() -> UIView {
        
        let layer = CAGradientLayer()
        
        layer.type = .axial
        layer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        layer.colors = [UIColor(red: 180, green: 180, blue: 180, alpha: 1).cgColor,
                        UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let view = UIView(frame: self.bounds)
        view.layer.addSublayer(layer)
        view.roundCorners(cornerRadius: 15, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        return view
    }
    
    func backViewWithBorder() -> UIView {
        let view = backView()
        
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        
        return view
    }
    
    func selectedBackView() -> UIView{
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
        
        let view = UIView(frame: self.bounds)
        view.layer.addSublayer(layer)
        view.roundCorners(cornerRadius: 15, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        
        return view
    }
    
    func selectedBackViewWithBorder() -> UIView {
        let view = selectedBackView()
        
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        
        return view
    }
}
