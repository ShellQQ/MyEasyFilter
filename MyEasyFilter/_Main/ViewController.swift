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
    
    @IBAction func openAlbum(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        print("open album")
    }
    @IBAction func openCamera(_ sender: UIButton) {
        // 檢查裝置是否具有拍照功能
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            
            // 設定相片來源為相機
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            // 開啟拍照介面
            show(imagePicker, sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            //nextController.originalImage = image
            // 顯示下一個畫面的兩種方式
            //navigationController?.pushViewController(nextController, animated: true)
            self.present(nextController, animated: true, completion: nil)
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

