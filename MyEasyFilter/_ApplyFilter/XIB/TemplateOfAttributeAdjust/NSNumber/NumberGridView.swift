//
//  NumberGridView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/2.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class NumberGridView: UIView {

    var gridWidth: CGFloat = 300
    
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNumberGrid(gridWidth: CGFloat, num: Int, gridHeight: CGFloat = 15) {
        let spaceTop: CGFloat = 3
        
        stackView = UIStackView()
        stackView.spacing = gridWidth / CGFloat(num)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.randomColor()
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let view = UIView()
        
        for n in 0 ... num {
            if n % 5 == 0 {
                view.backgroundColor = .white
                
                // 最中間網格
                if n == num / 2 {
                    view.frame = CGRect(x: 0, y: 0, width: 1, height: gridHeight + spaceTop * 2)
                }
                // 間隔5的白色網格
                else {
                   view.frame = CGRect(x: 0, y: 0, width: 1, height: gridHeight)
                }
            }
                // 其他網格
            else {
                view.backgroundColor = .gray
                view.frame = CGRect(x: 0, y: 0, width: 1, height: gridHeight)
            }
            stackView.addArrangedSubview(view)
        }
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
