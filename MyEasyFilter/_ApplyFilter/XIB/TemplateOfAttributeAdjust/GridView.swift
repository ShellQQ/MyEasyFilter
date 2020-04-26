//
//  GridView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/29.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class GridView: UIView {
    //let screenWidth = UIScreen.main.bounds.size.width
    var gridWidth: CGFloat = 300
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {    return  }
        
        // 保存現行繪圖區域狀態
        context.saveGState()
            
        // 設定繪圖區域座標，將 (0, 0) 改為左下角
        var t = context.ctm
        t = t.inverted()
        context.concatenate(t)
            
        // 開始繪圖
        drawGrid(in: context, num: 30)
        
        // 還原繪圖區域狀態
        context.restoreGState()
    }
    
    func drawGrid(in context: CGContext, num: Int, gridHeight: CGFloat = 15) {
        let spacex = gridWidth / CGFloat(num) * 2
        let spaceTop: CGFloat = 3
        
        for n in 0 ... num {
            
            var color = UIColor.white.cgColor
            let x = CGFloat(n) * spacex
            var pt1 = CGPoint(x: x, y: spaceTop)
            var pt2 = CGPoint(x: x, y: spaceTop + gridHeight)
            
            if n % 5 == 0 {
                // 最中間網格
                if n == num / 2 {
                    pt1 = CGPoint(x: x, y: 0)
                    pt2 = CGPoint(x: x, y: spaceTop * 2 + gridHeight)
                    drawLine(in: context, color: color, from: pt1, to: pt2)
                }
                // 間隔5的白色網格
                else {
                    drawLine(in: context, color: color, from: pt1, to: pt2)
                }
            }
            // 其他網格
            else {
                color = UIColor.gray.cgColor
                
                drawLine(in: context, color: color, from: pt1, to: pt2)
            }
        }
    }
    
    func drawLine(in context: CGContext, color: CGColor, from pt1: CGPoint, to pt2: CGPoint) {
        context.setLineWidth(1)
        context.setStrokeColor(color)
        
        context.move(to: pt1)
        context.addLine(to: pt2)
        context.drawPath(using: .stroke)
    }

}
