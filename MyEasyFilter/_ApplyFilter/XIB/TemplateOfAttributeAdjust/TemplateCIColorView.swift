//
//  TemplateCIColorView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateCIColorView: UIView {

    // -- First Row ----------------------------------------------------------------------
    //    - attributeNameLabel : attributeNameText 可取得及設定其 text 值
    //    - valueLabel
    // -----------------------------------------------------------------------------------
    private lazy var firstRowView: UIView = {
        let view = UIView()
        
        view.addSubview(attributeNameLabel)
        attributeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        attributeNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        attributeNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(colorView)
        colorView.translatesAutoresizingMaskIntoConstraints = false
        colorView.leadingAnchor.constraint(equalTo: attributeNameLabel.trailingAnchor, constant: 20).isActive = true
        colorView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -2).isActive = true
        colorView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        colorView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        return view
    }()
    
    private lazy var attributeNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 18)
        
        return label
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        //view.randomColor()
        
        return view
    }()
    
    var attributeNameText: String {
        get {
            return attributeNameLabel.text ?? ""
        }
        set {
            attributeNameLabel.text = newValue
        }
    }
    
    // -- Second Row ---------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    private lazy var secondRowView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [redSlider, greenSlider, blueSlider, alphaSlider])
        
        view.spacing = 10
        
        view.axis = .horizontal
        view.distribution = .fillEqually
     
        return view
    }()
    
    lazy var redSlider: TemplateSlider = {
        let slider = TemplateSlider()
       
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var greenSlider: TemplateSlider = {
        let slider = TemplateSlider()
    
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var blueSlider: TemplateSlider = {
        let slider = TemplateSlider()

        slider.minimumValue = 0
        slider.maximumValue = 1
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var alphaSlider: TemplateSlider = {
        let slider = TemplateSlider()
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    // -- Init ---------------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(firstRowView)
        
        firstRowView.translatesAutoresizingMaskIntoConstraints = false
        firstRowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        firstRowView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstRowView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        firstRowView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(secondRowView)
        
        secondRowView.translatesAutoresizingMaskIntoConstraints = false
        secondRowView.topAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: 5).isActive = true
        secondRowView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        secondRowView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        secondRowView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    convenience init(info: FilterAttribute) {
        self.init()
        
        guard let value = info.value as? CIColor else { return }
        
        attributeNameText = FilterData.data.selectedAttribute
        colorView.backgroundColor = UIColor(ciColor: value)
        setSliderValues(color: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // -- Function -----------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    func setSliderValues(color: CIColor) {
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
        alphaSlider.value = Float(color.alpha)
    }

    @objc func onSliderChange(_ sender: UISlider) {
        
        let color = CIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        
        colorView.backgroundColor = UIColor(ciColor: color)
        FilterData.data.changeSelectedAttributeValue(value: color)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterChangeEvent"), object: self)
    }
}
