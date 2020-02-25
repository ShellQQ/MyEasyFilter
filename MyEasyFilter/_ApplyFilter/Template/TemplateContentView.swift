//
//  TemplateContentView.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/15.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class TemplateContentView: UIView {

    private var templateType: TemplateType = .normal
    
    // -- First Row View -----------------------------------------------------------------
    //    - titleLabel
    //    - nameLabel -- TemplateType.normal
    //    - infoButton -- TemplateType.filterDetail
    //    - foldButton -- TemplateType.filterDetail
    // -----------------------------------------------------------------------------------
    private lazy var firstRowView: UIView = {
        let view = UIView()
        //view.backgroundColor = randomColor()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        switch templateType{
        case .normal:
            view.addSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20).isActive = true
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
        case .filterDetail:
            view.addSubview(infoButton)
            view.addSubview(foldButton)
            
            infoButton.translatesAutoresizingMaskIntoConstraints = false
            infoButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 20).isActive = true
            infoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -3).isActive = true
            
            foldButton.translatesAutoresizingMaskIntoConstraints = false
            foldButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            foldButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -3).isActive = true
        case .attributeAdjust:
            print("attribute")
        }

        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = randomColor()
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 18)
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont(name: "Kailasa", size: 14)
        
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = TemplateButton(imageName: "info", size: CGSize(width: 18, height: 18))
        return button
    }()
    
    private lazy var foldButton: UIButton = {
        let button = TemplateButton(imageName: "down-arrow", backgroundColor: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1), size: CGSize(width: 18, height: 18))
        return button
    }()
    
    var titleText: String {
        get {
            return titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var nameText: String {
        get {
            return nameLabel.text ?? ""
        }
        set {
            nameLabel.text = newValue
        }
    }
    
    // -- Second Row View ----------------------------------------------------------------
    //    - collectionView
    //    - descripLabel -- TemplateType.filterDetail
    // -----------------------------------------------------------------------------------
    var listCollectionView: UICollectionView!
    private var collectionViewLayout: UICollectionViewFlowLayout!
    
    private lazy var secondRowView: UIView = {
        let view = UIView()

        switch templateType{
        case .normal:
            break
            
        case .filterDetail:
            view.addSubview(descripLabel)
            descripLabel.translatesAutoresizingMaskIntoConstraints = false
            descripLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            descripLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            descripLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            descripLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        default:
            break
        }
        
        return view
    }()
    
    
  
    private lazy var descripLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kailasa", size: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        label.text = "test test test test"
        
        return label
    }()
    
    var descripText: String {
        get {
            return descripLabel.text ?? ""
        }
        set {
            descripLabel.text = newValue
        }
    }
    
    convenience init(type: TemplateType) {
        self.init()
        
        templateType = type
        
        addSubview(firstRowView)
        addSubview(secondRowView)
        
        firstRowView.translatesAutoresizingMaskIntoConstraints = false
        firstRowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        firstRowView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        firstRowView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        firstRowView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        secondRowView.translatesAutoresizingMaskIntoConstraints = false
        secondRowView.topAnchor.constraint(equalTo: firstRowView.bottomAnchor, constant: 5).isActive = true
        secondRowView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        secondRowView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        secondRowView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func initListCollectionView(cellSize: CGSize, cellIdentifier: String) -> UICollectionView{
        collectionViewLayout = UICollectionViewFlowLayout()
        
        collectionViewLayout.itemSize = cellSize
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumLineSpacing = 5
        
        listCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: collectionViewLayout)
        //collectionView.collectionViewLayout = collectionViewLayout
        // 是否為滾動視圖啟用分頁
        //collectionView.isPagingEnabled = true
        // 控制是否啟用滾動到頂部的手勢
        listCollectionView.scrollsToTop = false
        // 控制滾動視圖是否在內容邊緣彈跳並再次彈回
        listCollectionView.bounces = false
        // 控制水平滾動指示器是否可見
        listCollectionView.showsHorizontalScrollIndicator = false
        // 設定Cell是否可多選
        //collectionView.allowsMultipleSelection = isMultiSel
        listCollectionView.backgroundColor = nil
        
        let cellXIB = UINib.init(nibName: cellIdentifier, bundle: Bundle.main)
        listCollectionView.register(cellXIB, forCellWithReuseIdentifier: cellIdentifier)
        
        secondRowView.addSubview(listCollectionView)
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        listCollectionView.topAnchor.constraint(equalTo: secondRowView.topAnchor).isActive = true
        listCollectionView.leadingAnchor.constraint(equalTo: secondRowView.leadingAnchor).isActive = true
        listCollectionView.trailingAnchor.constraint(equalTo: secondRowView.trailingAnchor).isActive = true
        listCollectionView.bottomAnchor.constraint(equalTo: secondRowView.bottomAnchor).isActive = true
        
        return listCollectionView
    }

    func changeDescripLabelAndCollectionView(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 1) {
                self.descripLabel.alpha = ( self.descripLabel.alpha + 1.0 ).truncatingRemainder(dividingBy: 2)
                self.listCollectionView.alpha = ( self.listCollectionView.alpha + 1.0 ).truncatingRemainder(dividingBy: 2)
            }
        }
        else {
            descripLabel.alpha = ( descripLabel.alpha + 1.0 ).truncatingRemainder(dividingBy: 2)
            listCollectionView.alpha = ( listCollectionView.alpha + 1.0 ).truncatingRemainder(dividingBy: 2)
        }
    }
    
    func showDiscripLabel() {
        descripLabel.isHidden = false
        listCollectionView.isHidden = true
    }
    
    func showListCollectionView() {
        descripLabel.isHidden = true
        listCollectionView.isHidden = false
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

enum TemplateType {
    case normal
    case filterDetail
    case attributeAdjust
}
