//
//  TemplateButton.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateButton: UIButton {
    
    convenience init(imageName: String, backgroundColor: UIColor = UIColor(red: 250, green: 163, blue: 43, alpha: 1), size: CGSize = CGSize(width: 30, height: 30)) {
        self.init()
        
        //setImage(UIImage(named: imageName), for: .normal)
   
        let image = UIImage(named: imageName)

        setImage(image?.imageResize(newSize: size), for: .normal)
        setBackgroundImage(backgroundColor.asImage(size: size), for: .normal)
        
        roundAllCorners(cornerRadius: size.width / 2)
    }
    
    func setSelectImage(imageName: String, backgroundColor: UIColor, size: CGSize) {
        let image = UIImage(named: imageName)
        
        setImage(image?.imageResize(newSize: size), for: .selected)
        setBackgroundImage(backgroundColor.asImage(size: size), for: .selected)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
