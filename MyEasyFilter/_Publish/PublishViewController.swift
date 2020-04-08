//
//  PublishViewController.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/14.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit

class PublishViewController: UIViewController {

    @IBAction func backPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.roundAllCorners(cornerRadius: 30)
        view.addGradientLayer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    func startPublish() {
        let image = UIImage(named: "Activity")      // 分享的圖片
        let urlLink = ""        // 分享的連結
        let activityController = UIActivityViewController(activityItems: [urlLink, image], applicationActivities: [])   // 建立分享的 Controller
        
        present(activityController, animated: true, completion: nil)    // 顯示分享畫面
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
