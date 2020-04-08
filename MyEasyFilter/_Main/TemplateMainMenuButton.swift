//
//  TemplateMainMenuButton.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/31.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateMainMenuButton: UIView {
    
    private var highlightView: UIView!

    convenience init(backImageName: String, iconImageName: String, text: String, direction: String) {
        self.init()
        
        roundAllCorners(cornerRadius: 20)
        
        // back image view
        let backImageView = UIImageView(image: UIImage(named: backImageName))
        
        backImageView.clipsToBounds = true
        backImageView.contentMode = .scaleAspectFill
        
        self.addSubview(backImageView)
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        // icon view
        let iconImageView = UIImageView(image: UIImage(named: iconImageName))
        let iconLabel = UILabel()
        
        iconLabel.text = text
        iconLabel.textColor = .white
        
        let iconBackView = UIView()
        iconBackView.backgroundColor = .black
        iconBackView.alpha = 0.5
        
        let iconView = UIView()
        
        iconView.addSubview(iconBackView)
        iconBackView.translatesAutoresizingMaskIntoConstraints = false
        iconBackView.topAnchor.constraint(equalTo: iconView.topAnchor).isActive = true
        iconBackView.bottomAnchor.constraint(equalTo: iconView.bottomAnchor).isActive = true
        iconBackView.leadingAnchor.constraint(equalTo: iconView.leadingAnchor).isActive = true
        iconBackView.trailingAnchor.constraint(equalTo: iconView.trailingAnchor).isActive = true
        
        iconView.addSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconView.centerYAnchor).isActive = true
        
        iconView.addSubview(iconLabel)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.centerXAnchor.constraint(equalTo: iconView.centerXAnchor).isActive = true
        iconLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5).isActive = true
        
        self.addSubview(iconView)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        iconView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) / 5 * 2).isActive = true
        
        if direction == "right" {
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
        else {
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
        
        /*let buttonStackView = UIStackView()
        buttonStackView.spacing = 0
        buttonStackView.distribution = .fill
        
        if direction == "right" {
            buttonStackView.addArrangedSubview(backImageView)
            buttonStackView.addArrangedSubview(iconView)
        }
        else {
            buttonStackView.addArrangedSubview(iconView)
            buttonStackView.addArrangedSubview(backImageView)
        }
        
        iconView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 40) / 5 * 2).isActive = true
        
        self.addSubview(buttonStackView)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true*/
       
        
        
        // high light
        highlightView = UIView()
        highlightView.backgroundColor = UIColor.white
        highlightView.alpha = 0.2
        highlightView.isHidden = true
        
        self.addSubview(highlightView)
        
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        highlightView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        highlightView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        highlightView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        highlightView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        //setImage(UIImage(named: backImageName), for: .normal)
        //setBackgroundImage(UIColor.black.asImage(size: CGSize(width: 300, height: 200)), for: .normal)
    }
    
    func isHighlight(_ bool: Bool) {
        highlightView.isHidden = !bool
    }

}
