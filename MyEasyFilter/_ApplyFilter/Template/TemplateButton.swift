//
//  TemplateButton.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateButton: UIButton {
    
    
    convenience init(imageName: String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setBackgroundImage(UIColor(red: 250, green: 163, blue: 43, alpha: 1).asImage(size: CGSize(width: 15, height: 15)), for: .normal)
        
        roundAllCorners(cornerRadius: 15)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
