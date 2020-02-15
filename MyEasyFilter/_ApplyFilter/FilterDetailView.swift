//
//  FilterDetailView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class FilterDetailView: UIView {
    
    let fullScrrenSize = UIScreen.main.bounds.size
    
    var valueYConstraint: NSLayoutConstraint!
    var attributeYConstraint: NSLayoutConstraint!
    
    lazy var topView: UIView = {
        let view = UIView()
        //view.backgroundColor = randomColor()
        return view
    }()
    
    lazy var changeValueView: UIView = {
        let view = UIView()
        
        //view.isHidden = true
        //view.backgroundColor = randomColor()
        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.layer.addSublayer(gradientLayer(layerHeight: 110))
        
        view.isHidden = true

        return view
    }()

    lazy var selectAttributeView: UIView = {
        let view = UIView()
        //view.backgroundColor = randomColor()
        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.layer.addSublayer(gradientLayer(layerHeight: 110))
        
        view.isHidden = true
        
        return view
    }()
    
    lazy var chooseView: UIView = {
        let view = UIView()
        
        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        //view.addGradientLayer(startPoint: CGPoint(x: 0.5, y: 1.5))

        view.layer.addSublayer(gradientLayer(layerHeight: 190))
        
        return view
    }()
    
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView = UIStackView(arrangedSubviews: [topView, changeValueView, selectAttributeView, chooseView])
        stackView.spacing = -30
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        self.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        topView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        changeValueView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        selectAttributeView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        chooseView.heightAnchor.constraint(equalToConstant: 160).isActive = true

        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setConstraint)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        if let layer1 = changeValueView.layer.sublayers?[0] as? CAGradientLayer {
//            print("reset changeValueView layer")
//            layer1.frame = CGRect(x: 0, y: 0, width: self.fullScrrenSize.width, height: 110)
//        }
//
//        if let layer3 = chooseView.layer.sublayers?[0] as? CAGradientLayer {
//            print("reset chooseView layer")
//            layer3.frame = CGRect(x: 0, y: 0, width: self.fullScrrenSize.width, height: 160)
//        }
//    }

    @objc func setConstraint(_ sender: UITapGestureRecognizer) {
        //UIView.animate(withDuration: 0.5) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.changeValueView.isHidden = !self.changeValueView.isHidden
            self.changeValueView.alpha = self.changeValueView.isHidden ? 0.0 : 1.0
        }, completion: nil)
    }
    
    func randomColor() -> UIColor {
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return color
    }
    func gradientLayer(layerHeight: CGFloat) -> CAGradientLayer {
        let layer = CAGradientLayer()
        
        layer.type = .radial
        layer.frame = CGRect(x: 0, y: 0, width: self.fullScrrenSize.width, height: layerHeight)
        layer.colors = [UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1).cgColor,
                        UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor,
                        UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0.5, y: 1)
        layer.endPoint = CGPoint(x: 1.5 , y: 2.0)
        
        return layer
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
