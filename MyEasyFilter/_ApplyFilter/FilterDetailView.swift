//
//  FilterDetailView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/7.
//  Copyright © 2020 Nautilus. All rights reserved.
//
protocol AddOrRemoveFilterDelegate: class {
    func addFilter(categoryName: String, filterName: String)
    func removeFilter(filterName: String)
}

import UIKit

class FilterDetailView: UIView {
    
    // category 相關參數
    var categoryCollectionView: UICollectionView!
    let categoryCellIdentifier = "CategoryCollectionViewCell"
    let categoriesList = [["name": kCICategoryBlur, "img":""],
                          ["name": kCICategoryColorAdjustment, "img":""],
                          ["name": kCICategoryColorEffect, "img":""],
                          ["name": kCICategoryCompositeOperation, "img":""],
                          ["name": kCICategoryDistortionEffect, "img":""],
                          ["name": kCICategoryGenerator, "img":""],
                          ["name": kCICategoryGeometryAdjustment, "img":""],
                          ["name": kCICategoryGradient, "img":""],
                          ["name": kCICategoryHalftoneEffect, "img":""],
                          ["name": kCICategoryReduction, "img":""],
                          ["name": kCICategorySharpen, "img":""],
                          ["name": kCICategoryStylize, "img":""],
                          ["name": kCICategoryTileEffect, "img":""],
                          ["name": kCICategoryTransition, "img":""]]
    var selectedCategoryIndex: Int = 0
    var selectedCategoryName: String = ""

    // filter 相關參數
    var filterCollectionView: UICollectionView!
    let filterCellIdentifier = "FilterCollectionViewCell"
    var filterList: Array<String> = []
    var selectedFilterIndex: Int = 0
    var selectedFilterName: String = ""

    // Attribute 相關參數
    var attributeCollectionView: UICollectionView!
    let attributeCellIdentifier = "AttributeCollectionViewCell"
    var attributeList: Array<String> = []
    var selectedAttributeName: String = ""

    var stackView: UIStackView!
    
    //let fullScrrenSize = UIScreen.main.bounds.size
    //var valueYConstraint: NSLayoutConstraint!
    //var attributeYConstraint: NSLayoutConstraint!

    // -- top view : 為了顯示正常的隱藏view -------------------------------------------------
    // -----------------------------------------------------------------------------------
    lazy var topView: UIView = {
        let view = UIView()
        //view.backgroundColor = randomColor()
        return view
    }()
    
    // -- Change Value View : 調整濾鏡參數區塊 ----------------------------------------------
    //
    // -----------------------------------------------------------------------------------
    lazy var changeValueView: UIView = {
        let view = UIView()

        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.layer.addSublayer(gradientLayer(layerHeight: 110))
        
        view.isHidden = true

        return view
    }()

    // -- Select Attribute View : 選擇想要調整的濾鏡參數 -------------------------------------
    //    - selectAttributeSubview: 濾鏡說明，以及選擇濾鏡的參數
    // -----------------------------------------------------------------------------------
    lazy var selectAttributeView: UIView = {
        let view = UIView()

        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.layer.addSublayer(gradientLayer(layerHeight: 110))
        view.addSubview(selectAttributeSubview)
        
        selectAttributeSubview.translatesAutoresizingMaskIntoConstraints = false
        selectAttributeSubview.heightAnchor.constraint(equalToConstant: 55).isActive = true
        selectAttributeSubview.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        selectAttributeSubview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        selectAttributeSubview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
        
        view.isHidden = true
        view.alpha = 0

        return view
    }()
    
    lazy var selectAttributeSubview: TemplateContentView = {
        let view = TemplateContentView(type: .filterDetail)
        
        view.titleText = "Filter Detail"
        
        attributeCollectionView = view.initListCollectionView(cellSize: CGSize(width: 80, height: 30), cellIdentifier: attributeCellIdentifier)
        
        attributeCollectionView.delegate = self
        attributeCollectionView.dataSource = self
        
        attributeCollectionView.alpha = 0

        return view
    }()
    
    // -- choose view : 選擇濾鏡的分類及濾鏡 ------------------------------------------------
    //    - selectCategoryView: 選擇濾鏡的分類
    //    - seperatorView: 分隔線
    //    - selectFilterView: 選擇濾鏡
    // -----------------------------------------------------------------------------------
    lazy var chooseView: UIView = {
        let view = UIView()
        
        view.roundCorners(cornerRadius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.layer.addSublayer(gradientLayer(layerHeight: 190))
        
        let stackView = UIStackView(arrangedSubviews: [selectCategoryView, seperatorView, selectFilterView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true

        return view
    }()
    
    lazy var selectCategoryView: TemplateContentView = {
        let view = TemplateContentView(type: .normal)
        
        selectedCategoryName = categoriesList[selectedCategoryIndex]["name"] ?? ""
        
        view.titleText = "Category"
        view.nameText = CIFilter.localizedName(forCategory: selectedCategoryName)
        
        categoryCollectionView = view.initListCollectionView(cellSize: CGSize(width: 76, height: 30), cellIdentifier: categoryCellIdentifier)
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        return view
    }()
    
    lazy var selectFilterView: TemplateContentView = {
        let view = TemplateContentView(type: .normal)
        
        filterList = CIFilter.filterNames(inCategory: selectedCategoryName)
        selectedFilterName = filterList[selectedFilterIndex]
        
        view.titleText = "Filter"
        view.nameText = CIFilter.localizedName(forFilterName: selectedFilterName) ?? ""
        
        filterCollectionView = view.initListCollectionView(cellSize: CGSize(width: 100, height: 30), cellIdentifier: filterCellIdentifier)
        
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        return view
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.1
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //stackView = UIStackView(arrangedSubviews: [topView, changeValueView, selectAttributeView, chooseView])
        stackView = UIStackView()
        stackView.spacing = -30
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        self.addSubview(stackView)
        
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(changeValueView)
        stackView.addArrangedSubview(selectAttributeView)
        stackView.addArrangedSubview(chooseView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        topView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        changeValueView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        selectAttributeView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        chooseView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        //self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setConstraint)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 漸層背景
    func gradientLayer(layerHeight: CGFloat) -> CAGradientLayer {
        let layer = CAGradientLayer()
        
        layer.type = .radial
        layer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: layerHeight)
        layer.colors = [UIColor(red: 0.35, green: 0.35, blue: 0.35, alpha: 1).cgColor,
                        UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1).cgColor,
                        UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor]
        layer.startPoint = CGPoint(x: 0.5, y: 1)
        layer.endPoint = CGPoint(x: 1.5 , y: 2.0)
        
        return layer
    }
    
    func popUpAttributeView(isPop: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            self.selectAttributeView.isHidden = !isPop
            self.selectAttributeView.alpha = isPop ? 1.0 : 0.0
            }, completion: nil)
        
        
    }
    
    func changeDisplay() {
        if selectAttributeView.isHidden {
            selectAttributeSubview.changeDescripLabelAndCollectionView(animated: false)
        }
        else {
            selectAttributeSubview.changeDescripLabelAndCollectionView(animated: true)
        }
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
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

//    @objc func setConstraint(_ sender: UITapGestureRecognizer) {
//        //UIView.animate(withDuration: 0.5) {
//        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
//            self.changeValueView.isHidden = !self.changeValueView.isHidden
//            self.changeValueView.alpha = self.changeValueView.isHidden ? 0.0 : 1.0
//        }, completion: nil)
//    }
    
}

// -----------------------------------------------------------------------------------
// 設定 UICollectionView 內容
// selectCategoryView, selectFilterView, selectAttributeView, changeValueView
// -----------------------------------------------------------------------------------
extension FilterDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return categoriesList.count
        }
        
        else if collectionView == filterCollectionView {
            return filterList.count
        }
            
        else if collectionView == attributeCollectionView {
            return attributeList.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == categoryCollectionView {
            let catetoryDisplayName = CIFilter.localizedName(forCategory: categoriesList[indexPath.item]["name"]!)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! CategoryCollectionViewCell
            
            cell.label.text = catetoryDisplayName
            
            return cell
        }
        
        else if collectionView == filterCollectionView {
            //let filterDisplayName = CIFilter.localizedName(forFilterName: filterList[indexPath.item])
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterCellIdentifier, for: indexPath) as! FilterCollectionViewCell
            
            cell.labelText = CIFilter.localizedName(forFilterName: filterList[indexPath.item]) ?? ""
            cell.categoryName = selectedCategoryName
            cell.filterName = filterList[indexPath.item]
            cell.delegate = self.viewController() as? AddOrRemoveFilterDelegate
            
            return cell
        }
            
        else if collectionView == attributeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: attributeCellIdentifier, for: indexPath) as! AttributeCollectionViewCell
            
            cell.label.text = attributeList[indexPath.item]
            
            return cell
        }
 
        return UICollectionViewCell() 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            selectedCategoryIndex = indexPath.item
            selectedCategoryName = categoriesList[selectedCategoryIndex]["name"]!
            selectCategoryView.nameText = CIFilter.localizedName(forCategory: selectedCategoryName)

            filterList = CIFilter.filterNames(inCategory: selectedCategoryName)
            
            selectedFilterIndex = 0
            selectedFilterName = filterList[selectedFilterIndex]
            selectFilterView.nameText = CIFilter.localizedName(forFilterName: selectedFilterName) ?? ""
            filterCollectionView.reloadData()
            
            popUpAttributeView(isPop: false)
        }
            
        else if collectionView == filterCollectionView  {
            selectedFilterIndex = indexPath.item
            selectedFilterName = filterList[selectedFilterIndex]
            selectFilterView.nameText = CIFilter.localizedName(forFilterName: selectedFilterName) ?? ""
            
            if let filter = CIFilter(name: selectedFilterName) {
                
                attributeList = filter.inputKeys
                
                selectAttributeSubview.titleText = CIFilter.localizedName(forFilterName: selectedFilterName) ?? ""
                selectAttributeSubview.descripText = CIFilter.localizedDescription(forFilterName: selectedFilterName)!
                attributeCollectionView.reloadData()
            }
            
            popUpAttributeView(isPop: true)
        }
            
        else if collectionView == attributeCollectionView {
            selectedAttributeName = attributeList[indexPath.item]
            print("select attribute name: \(selectedAttributeName)")
        }
        
    }
}
