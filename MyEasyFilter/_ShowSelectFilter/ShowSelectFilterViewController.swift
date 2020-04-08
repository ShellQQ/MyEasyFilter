//
//  ShowSelectFilterViewController.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class ShowSelectFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var allFilters = Array<String>()
    
    // -- Top View -----------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    private lazy var topView: UIView = {
        let view = UIView()
        
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 22)
        label.text = "All Selected Filters"
        
        view.addSubview(label)
        view.addSubview(backButton)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = TemplateButton(imageName: "left-arrow")
        
        button.addTarget(self, action: #selector(backButtonTap(_:)), for: .touchUpInside)
        
        return button
    }()
    
    // -- Button View --------------------------------------------------------------------
    // 包含 filterTable
    // -----------------------------------------------------------------------------------
    private lazy var bottomView: UIView = {
        let view = UIView()
        
        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.addGradientLayer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100))

        view.addSubview(filterTable)
        
        filterTable.translatesAutoresizingMaskIntoConstraints = false
        filterTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        filterTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        filterTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        filterTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        return view
    }()
    
    private lazy var filterTable: UITableView = {
        let table = UITableView()
        
        table.separatorStyle = .none
        table.allowsSelection = false
        table.backgroundColor = UIColor.clear
        
        table.register(SelectFilterTableViewCell.self, forCellReuseIdentifier: "SelectedCell")
        
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
        
        //view.addGradientLayer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.backgroundColor = .black
        
        view.addSubview(topView)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(bottomView)
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        allFilters = FilterData.data.getAllSaveFilterNames()
        print("allFilters \(allFilters)")
    }
    
    // -- Function -----------------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    @objc func backButtonTap(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // -- Table DataSource ---------------------------------------------------------------
    // -----------------------------------------------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedCell", for: indexPath) as! SelectFilterTableViewCell
        let name = allFilters[indexPath.item]
        
        cell.setCell(filterName: name, parameters: FilterData.data.getAttributesInfoByName(filterName: name))
        
        return cell
    }

}
