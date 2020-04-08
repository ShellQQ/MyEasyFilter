//
//  ParameterTableViewCell.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/18.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class ParameterTableViewCell: UITableViewCell {

    // -- First Line ---------------------------------------------------------------------
    // 包含
    // keyLabel
    // -----------------------------------------------------------------------------------
    private lazy var keyLabel: UILabel = {
        let label = reuseLabel(color: UIColor(red: 250, green: 163, blue: 43, alpha: 1), fontSize: 18)
        return label
    }()
    
    // -- Second Line --------------------------------------------------------------------
    // 包含
    // classLabel, rangeLabel
    // -----------------------------------------------------------------------------------
    private lazy var secondLine: UIStackView = {
        
        let stackview = UIStackView(arrangedSubviews: [classLabel, rangeLabel])
        
        stackview.axis = .horizontal
        stackview.spacing = 10
        
        return stackview
    }()

    private lazy var classLabel: UILabel = {
        let label = reuseLabel(color: .gray, fontSize: 14)
        return label
    }()
    
    private lazy var rangeLabel: UILabel = {
        let label = reuseLabel(color: .gray, fontSize: 14)
        return label
    }()

    // -- Third Line --------------------------------------------------------------------
    // 包含
    // descriptionLabel
    // -----------------------------------------------------------------------------------
    private lazy var descriptionLabel: UILabel = {
        let label = reuseLabel(color: .white, fontSize: 16, lines: 0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        print("init info cell")
        
        self.backgroundColor = UIColor.clear
        
        // 背景黑色圓角矩形
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.roundAllCorners(cornerRadius: 20)
        
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        let cellStackView = UIStackView(arrangedSubviews: [keyLabel, secondLine, descriptionLabel])
        cellStackView.axis = .vertical
        cellStackView.spacing = 5
        cellStackView.alignment = .leading
        
        self.addSubview(cellStackView)
        
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
        
        // 第一行
//        self.addSubview(secondLine)
//
//        secondLine.translatesAutoresizingMaskIntoConstraints = false
//        secondLine.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
//        secondLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        secondLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        secondLine.heightAnchor.constraint(equalToConstant: 35).isActive = true
//
//        self.addSubview(descriptionLabel)
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        descriptionLabel.topAnchor.constraint(equalTo: secondLine.bottomAnchor, constant: 10).isActive = true
//        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
//        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
//        descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //parametersView.removeAllSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(info: FilterAttributeInfo) {
        keyLabel.text = info.attributeName
        classLabel.text = info.className
        rangeLabel.text = info.attributeRange
        descriptionLabel.text = info.description
    }

    func reuseLabel(color: UIColor, fontSize: CGFloat, lines: Int = 1, isFit: Bool = false) -> UILabel {
        let label = UILabel()
        
        label.textColor = color
        label.font = UIFont(name: "Kailasa", size: fontSize)
        label.numberOfLines = lines
        label.adjustsFontSizeToFitWidth = isFit
        
        return label
    }

}
