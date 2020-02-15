//
//  ApplyImageView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class ApplyImageView: UIView {
    
    var stackView: UIStackView!
    
    let fullScrrenSize = UIScreen.main.bounds.size
    
    weak var delegate: ApplyImageViewDelegate?
    
    var image: UIImage = UIImage() {
        didSet {
            print("image size \(image.size)")
            let size = image.size
            
            if size.height > size.width {
                // 圖片依照原比例顯示，可能會超出Image view尺寸
                centerView.contentMode = .scaleAspectFill
            }
            else {
                // 在Image view尺寸內，圖片依照原比例顯示
                centerView.contentMode = .scaleAspectFit
            }
            
            centerView.image = image
        }
    }
    
    // -- TOP VIEW -----------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    lazy var topView: UIView = {
        let view = UIView()
        
        view.addSubview(backButton)
        view.addSubview(publishButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        publishButton.translatesAutoresizingMaskIntoConstraints = false
        publishButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        publishButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        let labelStackView = UIStackView(arrangedSubviews: [filterLabel, categoryLabel])
        labelStackView.spacing = 0
        labelStackView.axis = .vertical
        labelStackView.alignment = .center
        
        view.addSubview(labelStackView)
        
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        labelStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = TemplateButton(imageName: "left-arrow")
        
        button.addTarget(self, action: #selector(backButtonTap(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var publishButton: UIButton = {
        let button = TemplateButton(imageName: "publish")
        
        button.addTarget(self, action: #selector(publishButtonTap(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 18)
        
        label.text = "Filter Name"
        
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.3, alpha: 1)
        label.font = UIFont(name: "Kailasa", size: 10)
        
        label.text = "Category Name"
        
        return label
    }()
    
    // -- CENTER VIEW --------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    lazy var centerView: UIImageView = {
        let view = UIImageView()

        view.clipsToBounds = true
        //view.backgroundColor = randomColor()
    
        return view
    }()
    
    // -- BOTTOM VIEW --------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    lazy var bottomView: UIView = {
        let view = UIView()
        
        view.addSubview(filterListButton)
        
        filterListButton.translatesAutoresizingMaskIntoConstraints = false
        filterListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        filterListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        
        return view
    }()
    
    lazy var filterListButton: UIButton = {
        let button = TemplateButton(imageName: "list")
        
        button.addTarget(self, action: #selector(filterListButtonTap(_:)), for: .touchUpInside)
        
        return button
    }()
    
    // -----------------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.roundAllCorners(cornerRadius: 30)
        self.addGradientLayer(frame: CGRect(x: 0, y: 0, width: fullScrrenSize.width, height: fullScrrenSize.height - 280))
        
        stackView = UIStackView(arrangedSubviews: [topView, centerView, bottomView])
        //stackView = UIStackView()
        stackView.spacing = 0
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        //caLayer = stackView.addGradientLayer()

        //stackView.addArrangedSubview(topView)
        //stackView.addArrangedSubview(centerView)
        //stackView.addArrangedSubview(bottomView)
        
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
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        //self.caLayer.frame = stackView.bounds
//        if let layer = self.layer.sublayers?[0] as? CAGradientLayer {
//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//                layer.frame = self.bounds
//            }, completion: nil)
//        }
//
//    }
    
    func createTestView() -> UIView{
        let view = UIView()
        view.backgroundColor = randomColor()
        
        return view
    }
    
    func randomColor() -> UIColor {
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return color
    }
    
    @objc func backButtonTap(_ button: UIButton) {
        delegate?.backToMain()
    }
    
    @objc func publishButtonTap(_ button: UIButton) {
        delegate?.goPublishPage()
    }
    
    @objc func filterListButtonTap(_ button: UIButton) {
        delegate?.goFilterListPage()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

protocol ApplyImageViewDelegate: class{
    func backToMain()
    func goPublishPage()
    func goFilterListPage()
}
