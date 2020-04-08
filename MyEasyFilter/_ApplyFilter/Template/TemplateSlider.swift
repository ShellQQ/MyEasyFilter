//
//  TemplateSlider.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/2.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateSlider: UISlider {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let minimumImage: UIImage = UIColor(red: 250, green: 163, blue: 43, alpha: 1)
                                    .asImage(size: CGSize(width: 10, height: 5))!
                                    .isRoundCorner(radius: 2.5, corners: [.topLeft, .bottomLeft])
                                    .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0))
        let maximumImage: UIImage = UIColor(red: 248, green: 203, blue: 113, alpha: 1)
                                    .asImage(size: CGSize(width: 15, height: 5))!
                                    .isRoundCorner(radius: 2.5, corners: .allCorners)
                                    .resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))

        setMinimumTrackImage(minimumImage, for: .normal)
        setMaximumTrackImage(maximumImage, for: .normal)
        setThumbImage(createThumbImage(), for: .normal)
        
        minimumValue = 0
        maximumValue = 10
        value = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createThumbImage() -> UIImage {
        let image1 = UIColor(red: 250, green: 163, blue: 43, alpha: 1).asImage(size: CGSize(width: 20, height: 20))!.isRoundCorner(radius: 10, corners: .allCorners)
        let image2 = UIColor.black.asImage(size: CGSize(width: 10, height: 10))!.isRoundCorner(radius: 5, corners: .allCorners)

        return image1.mergeWithImage(image2)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
