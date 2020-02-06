//
//  ApplyImageView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class ApplyImageView: UIView {
    
    lazy var topView: UIView = {
        let view = createTestView()
        return view
    }()
    
    lazy var centerView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = randomColor()
    
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = createTestView()
        return view
    }()
    
    var stackView: UIStackView!
    
    var caLayer: CAGradientLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.roundAllCorners(cornerRadius: 30)
        
        //stackView = UIStackView(arrangedSubviews: [topView, centerView, bottomView])
        stackView = UIStackView()
        stackView.spacing = 0
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        caLayer = stackView.addGradientLayer()

        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(centerView)
        stackView.addArrangedSubview(bottomView)
        
        self.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.caLayer.frame = stackView.bounds
    }
    
    func createTestView() -> UIView{
        let view = UIView()
        //view.backgroundColor = randomColor()
        
        return view
    }
    
    func randomColor() -> UIColor {
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return color
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
