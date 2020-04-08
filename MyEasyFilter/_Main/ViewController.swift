//
//  ViewController.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/5.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private lazy var openAlbumButton: TemplateMainMenuButton = {
        let view = TemplateMainMenuButton(backImageName: "gallery_button", iconImageName: "gallery", text: "Album", direction: "left")

        view.isUserInteractionEnabled = true
        
        let tap = UILongPressGestureRecognizer(target:self, action:#selector(ViewController.openAlbum(_:)))
        tap.minimumPressDuration = 0
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var openCameraButton: TemplateMainMenuButton = {
        let view = TemplateMainMenuButton(backImageName: "camera_button", iconImageName: "camera", text: "Camera", direction: "left")
        view.isUserInteractionEnabled = true
        
        let tap = UILongPressGestureRecognizer(target:self, action:#selector(ViewController.openCamera(_:)))
        tap.minimumPressDuration = 0
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    // 將 Status Bar 修改為 light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGradientLayer(frame: UIScreen.main.bounds)
        
        let buttonStackView = UIStackView(arrangedSubviews: [openAlbumButton, openCameraButton])
        
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 20

        view.addSubview(buttonStackView)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        // 主畫面加上漸層背景圖層
//        view.addGradientLayer(frame: view.frame)
//        if let layer = view.layer.sublayers?[0] as? CAGradientLayer {
//            layer.colors = [UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1).cgColor,
//                            UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1).cgColor,
//                            UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1).cgColor]
//        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
        // 調整照片方向
        let fixImage = image.fixOrientation()
        // 儲存照片
        // UIImageWriteToSavedPhotosAlbum(fixImage, nil, nil, nil)
        
        self.dismiss(animated: true) {
            self.presentApplyFilterStoryboard(image: fixImage)
        }
        
        //performSegue(withIdentifier: "mainToFilterCollectionPage", sender: self)
        /*let image = info[.originalImage] as! UIImage
         selectImage = image
         UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
         dismiss(animated: true, completion: nil)*/
        
        //if let controller = storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") {
        //    present(controller, animated: true, completion: nil)
        //}
    }
    
    func presentApplyFilterStoryboard(image: UIImage) {
        let nextStoryboard = UIStoryboard(name: "ApplyFilter", bundle: nil)
        if let nextController = nextStoryboard.instantiateViewController(withIdentifier: "ApplyFilter") as? ApplyFilterViewController {
            nextController.originalImage = image
            // 顯示下一個畫面的兩種方式
            //navigationController?.pushViewController(nextController, animated: true)
            self.present(nextController, animated: true, completion: nil)
        }
    }

    @objc func openCamera(_ recognizer: UITapGestureRecognizer) {
        let view = recognizer.view as! TemplateMainMenuButton
        
        if recognizer.state == .began {
            view.isHighlight(true)
            return
        }
        
        if recognizer.state == .changed {
            return
        }
        
        if recognizer.state == .possible || recognizer.state == .recognized {
            
            view.isHighlight(false)
            
            // 檢查裝置是否具有拍照功能
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                
                // 設定相片來源為相機
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                
                // 開啟拍照介面
                show(imagePicker, sender: self)
            }
            
            return
        }
    }
    
    @objc func openAlbum(_ recognizer: UITapGestureRecognizer) {
        let view = recognizer.view as! TemplateMainMenuButton
        
        if recognizer.state == .began {
            view.isHighlight(true)
            return
        }
        
        if recognizer.state == .changed {
            return
        }
        
        if recognizer.state == .possible || recognizer.state == .recognized {
            
            view.isHighlight(false)
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
            
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == "mainToFilterCollectionPage"{
        //            let destination = segue.destination as! FilterCollectionViewController
        //            destination.filterImage = selectImage
        //            print(destination)
        //        }
        //        else if segue.identifier == "toCameraSegue"{
        //            let destination = segue.destination as! CameraViewController
        //            print(destination)
        //       }
    }
}

