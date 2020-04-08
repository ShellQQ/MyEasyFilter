//
//  SelectFilterTableViewCell.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/15.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class SelectFilterTableViewCell: UITableViewCell {

    private var filterName: String = ""
    
    private lazy var titleView: UIView = {
        let view = UIView()
        //view.randomColor()
        view.addSubview(filterNameLabel)
        
        filterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        filterNameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        filterNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        view.addSubview(infoButton)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        infoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return view
    }()
    
    private lazy var filterNameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(red: 250, green: 163, blue: 43, alpha: 1)
        label.font = UIFont(name: "Kailasa", size: 18)
        
        return label
    }()
    
    private lazy var infoButton: TemplateButton = {
        let button = TemplateButton(imageName: "info", size: CGSize(width: 18, height: 18))
        
        button.addTarget(self, action: #selector(goInfoPage(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    private lazy var parametersView: UIStackView = {
        let stackview = UIStackView()
        //stackview.randomColor()
        stackview.spacing = 0
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
    
        return stackview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.roundAllCorners(cornerRadius: 20)
        
        self.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
        self.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        self.addSubview(parametersView)
        parametersView.translatesAutoresizingMaskIntoConstraints = false
        parametersView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        parametersView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        parametersView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        parametersView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        parametersView.removeAllSubviews()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(filterName: String, parameters: Dictionary<String, FilterAttribute>) {
        //filterNameLabel.text = filterName + " ( \(CIFilter.localizedName(forFilterName: filterName)!) )"
        self.filterName = filterName
        filterNameLabel.text = filterName

        for info in parameters {
            parametersView.addArrangedSubview(parameterNameView(name: info.key))
            parametersView.addArrangedSubview(parameterValueView(info: info.value))
        }
    }
    
    func parameterNameView(name: String) -> UIView {
        let view = UIView()
        
        view.roundAllCorners(cornerRadius: 5)
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        
        // 點
        let dotView = UIView()
        dotView.roundAllCorners(cornerRadius: 5)
        dotView.backgroundColor = UIColor(red: 250, green: 163, blue: 43, alpha: 1)
        
        view.addSubview(dotView)
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        dotView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        dotView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        dotView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let nameLabel = parameterLabel()
        
        nameLabel.font = UIFont(name: "Kailasa", size: 14)
        nameLabel.textColor = UIColor(red: 248, green: 203, blue: 113, alpha: 1)
        nameLabel.text = name
        
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: dotView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        
        return view
    }
    
    func parameterValueView(info: FilterAttribute) -> UIView {
        let view = UIView()

        // parameter class name label
        let classNameLabel = parameterLabel()
        classNameLabel.font = UIFont(name: "Kailasa", size: 14)
        classNameLabel.text = info.className
        
        //parameter value label
        let valueLabel = parameterLabel()
        
        valueLabel.font = UIFont(name: "Kailasa", size: 14)
        
        switch info.className {
        case "NSNumber":
            valueLabel.text = "\(info.value as? NSNumber ?? 0)"
        case "CIVector":
            if let value = info.value as? CIVector {
                valueLabel.text = "(\(String(describing: value)))"
              
            }
            else {
                valueLabel.text = "unknow"
            }
        case "CIColor":
            if let value = info.value as? CIColor {
                valueLabel.text = "\(String(describing: value))"
            }
            else {
                valueLabel.text = "unknow"
            }
        default:
            valueLabel.text = ""
        }

        let labelStackView = UIStackView(arrangedSubviews: [classNameLabel, valueLabel])
        labelStackView.spacing = 8
        labelStackView.axis = .horizontal
        labelStackView.distribution = .fill
        labelStackView.alignment = .center

        
        classNameLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        view.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        labelStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -2).isActive = true
        
        return view
    }

    func parameterLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 14)
        
        return label
    }
    
    @objc func goInfoPage(_ sender: UIButton) {
        
        guard let controller = self.viewController() else { return }
        
        let nextStoryboard = UIStoryboard(name: "Info", bundle: nil)
        
        if let nextController = nextStoryboard.instantiateViewController(withIdentifier: "Info") as? InfoViewController {
            nextController.filterName = filterName
            controller.present(nextController, animated: true, completion: nil)
        }
    }

}
