//
//  TemplateNSNumberView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/28.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateNSNumberView: UIView {
    
    var gridWidth: CGFloat = 300
    
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
    private lazy var secondRowView: UIView = {
        let view = UIView()
 
        //view.addSubview(gridView)
        
        view.addSubview(valueSlider)
        
        valueSlider.translatesAutoresizingMaskIntoConstraints = false
        valueSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        valueSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        valueSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        valueSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //gridView.createNumberGrid(gridWidth: self.gridWidth, num: 30)
        
        return view
    }()
    
    lazy var valueSlider: UISlider = {
        let slider = TemplateSlider()
        
        slider.addTarget(self, action: #selector(onSliderChange(_:)), for: .valueChanged)
        
        return slider
    }()
    
    lazy var gridView: NumberGridView = {
        let view = NumberGridView()
        
        return view
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
        
        let value = (info.value as? NSNumber ?? 0).floatValue
        attributeNameText = FilterData.data.selectedAttribute
        valueText = "\(value)"
        setSliderValues(min: info.minValue ?? 0, max: info.maxValue ?? value * 2 , defalut: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // -- Function -----------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    func setSliderValues(min: Float, max: Float, defalut: Float) {
        valueSlider.minimumValue = min
        valueSlider.maximumValue = max
        valueSlider.value = defalut
        print("min: \(min), max: \(max), value: \(defalut)")
    }
    
    @objc func onSliderChange(_ sender: UISlider) {
        print("value: \(sender.value)")
        FilterData.data.changeSelectedAttributeValue(value: sender.value)
        valueText = "\(sender.value)"
        //let info: Dictionary<String, Any> = ["filterName": "", "attrName": "name", "value":sender.value]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FilterChangeEvent"), object: self)
        //NotificationCenter.default.post(NSNumberInfo(name: "attrName", value: sender.value))
        //NotificationCenter.default.post(InputEvent.NSNumberInfo(name: "attrName", value: sender.value))
    }
}
