//
//  TemplateCIVectorView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateCIVectorView: UIView {

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
        
        view.addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.leadingAnchor.constraint(equalTo: attributeNameLabel.trailingAnchor, constant: 20).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    private lazy var attributeNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 18)
        
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .gray
        label.font = UIFont(name: "Kailasa", size: 14)
        
        return label
    }()
    
    var attributeNameText: String {
        get {
            return attributeNameLabel.text ?? ""
        }
        set {
            attributeNameLabel.text = newValue
        }
    }
    
    var valueText: String {
        get {
            return valueLabel.text ?? ""
        }
        set {
            valueLabel.text = newValue
        }
    }
    
    // -- Second Row ---------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    private lazy var secondRowView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [xSlider, ySlider, zSlider, wSlider])
        
        view.spacing = 10
        
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        return view
    }()
    
    lazy var xSlider: UISlider = {
        let slider = TemplateSlider()
        slider.minimumValue = 0
        slider.maximumValue = 250
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var ySlider: UISlider = {
        let slider = TemplateSlider()
        slider.minimumValue = 0
        slider.maximumValue = 300
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var zSlider: UISlider = {
        let slider = TemplateSlider()
        slider.minimumValue = 0
        slider.maximumValue = 250
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var wSlider: UISlider = {
        let slider = TemplateSlider()
        slider.minimumValue = 0
        slider.maximumValue = 300
        
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
        
        guard let value = info.value as? CIVector else { return }
        
        attributeNameText = FilterData.data.selectedAttribute
        //valueText = value.stringRepresentation
        
        print("CIVector")
        print(value.stringRepresentation)
        print(value.cgAffineTransformValue)
        print(value.cgPointValue)
        print(value.cgRectValue)
        print("\(String(describing: info.minValue))")
        print("\(String(describing: info.maxValue))")
        setSliderValues(civector: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // -- Function -----------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    func setSliderValues(civector: CIVector) {
        xSlider.value = Float(civector.x)
        ySlider.value = Float(civector.y)
        zSlider.value = Float(civector.z)
        wSlider.value = Float(civector.w)
    }
    
    @objc func onSliderChange(_ sender: UISlider) {
        let vector = CIVector(x: CGFloat(xSlider.value), y: CGFloat(ySlider.value), z: CGFloat(zSlider.value), w: CGFloat(wSlider.value))
        //valueText = vector.stringRepresentation
        FilterData.data.changeSelectedAttributeValue(value: vector)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterChangeEvent"), object: self)  
    }
}
