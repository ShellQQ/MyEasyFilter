//
//  InfoViewController.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/26.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var filterName: String = "CIBokehBlur"
    var filterInfo: FilterInfo?
    
    // -- Top View -----------------------------------------------------------------------
    // 包含
    // nameLabel, categoryLabel
    // backButton
    // -----------------------------------------------------------------------------------
    private lazy var topView: UIView = {
        let view = UIView()
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 22).isActive = true
        
        view.addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 22)
        label.text = filterName + " ( " + filterInfo!.filterDisplayName + " )"
        
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .gray
        label.font = UIFont(name: "Kailasa", size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = filterInfo!.filterCategory
        
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = TemplateButton(imageName: "cancle")
        
        button.addTarget(self, action: #selector(backButtonTap(_:)), for: .touchUpInside)
        
        return button
    }()
    // -- Middle View --------------------------------------------------------------------
    // 包含
    // iosVersionView, macVewsionView, descriptionLabel
    // -----------------------------------------------------------------------------------
    private lazy var middleView: UIView = {
        let view = UIView()
        
        view.addGradientLayer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200))
        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        let iosView = versionView(viewText: "iOS " + filterInfo!.iosVersion + "+", color: UIColor(red: 250, green: 163, blue: 43, alpha: 1))
        let macView = versionView(viewText: "MAC " + filterInfo!.macVersion + "+", color: UIColor.blue)
        
        let versionStackView = UIStackView(arrangedSubviews: [iosView, macView])
        versionStackView.spacing = 15
        versionStackView.axis = .vertical
        //versionStackView.distribution = .fill
        
        iosView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iosView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        macView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        macView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        let stackview = UIStackView(arrangedSubviews: [versionStackView, descriptionLabel])
        
        stackview.spacing = 15
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.alignment = .top
        
        view.addSubview(stackview)
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        stackview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        stackview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        stackview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 16)
        label.numberOfLines = 0
        label.text = filterInfo!.filterDiscription
        
        return label
    }()

    private lazy var referenceLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()

    // -- Bottom View --------------------------------------------------------------------
    // 包含
    // parameterTable
    // -----------------------------------------------------------------------------------
    private lazy var bottomView: UIView = {
        let view = UIView()
        
        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.addGradientLayer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200))
        //view.randomColor()
        
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        
        view.addSubview(parameterTable)
        
        parameterTable.translatesAutoresizingMaskIntoConstraints = false
        parameterTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        parameterTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        parameterTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        parameterTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 22)
        label.text = "Parameters"
        
        return label
    }()
    
    private lazy var parameterTable: UITableView = {
        let table = UITableView()

        table.separatorStyle = .none
        table.allowsSelection = false
        table.backgroundColor = UIColor.clear
        //table.randomColor()
        
        print("attributes:\(filterInfo!.attributes.count)")
        table.register(ParameterTableViewCell.self, forCellReuseIdentifier: "InfoCell")
        
        table.dataSource = self
        table.delegate = self
        
        return table
    }()
    
    // -----------------------------------------------------------------------------------
    // 設定 Status bar 為淺色
    // -----------------------------------------------------------------------------------
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // -- View Did Load ------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterInfo = FilterData.data.getFilterInfo(filterName: filterName)

        view.backgroundColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [topView, middleView, bottomView])
        
        stackView.spacing = -30
        stackView.axis = .vertical
        stackView.distribution = .fill
        //stackView.alignment = .center

        view.addSubview(stackView)
        
        //middleView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    }
    
    // -- Function -----------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    func versionView(viewText: String, color: UIColor) -> UIView {
        let view = UIView()
        
        view.backgroundColor = color
        view.roundAllCorners(cornerRadius: 15)
        
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 12)
        label.text = viewText
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 2).isActive = true
        
        return view
    }
    
    @objc func backButtonTap(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // -- Table DataSource ---------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterInfo!.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! ParameterTableViewCell

        cell.setCell(info: (filterInfo?.attributes[indexPath.item])!)
        
        return cell
    }

}
