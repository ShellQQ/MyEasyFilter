//
//  ApplyFilterViewController.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/2/6.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ApplyFilterViewController: UIViewController{
    
    var originalImage: UIImage?
    
    var stackView: UIStackView!
    //var detailHeightConstraint: NSLayoutConstraint!
    
    lazy var applyImageView: ApplyImageView = {
        let view = ApplyImageView()
        
        view.delegate = self
        if let image = originalImage {
            view.image = image
        }
        
        return view
    }()
    
    lazy var gapView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var filterDetailView: FilterDetailView = {
        let view = FilterDetailView()

        // 設定 filterDetailView 的 Constraint
        /*detailHeightConstraint = NSLayoutConstraint(item: view,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: self.stackView,
                                                    attribute: .height,
                                                    multiplier: 0,
                                                    constant: 320)
        NSLayoutConstraint.activate([detailHeightConstraint])*/

        return view
    }()
    
    lazy var bannerView: GADBannerView = {
        
        // -------------- 廣告尺寸設定 ---------------------------------------------------------
        // 詳細尺寸 https://developers.google.com/admob/ios/banner?hl=zh-TW#banner_sizes
        // kGADAdSizeBanner             320x50      Banner                  Phones and tablets
        // kGADAdSizeLargeBanner        320x100     Large banner            Phones and tablets
        // kGADAdSizeMediumRectangle    300x250     IAB medium rectangle    Phones and tablets
        // kGADAdSizeFullBanner         468x60      IAB full-size banner    Tablets
        // kGADAdSizeLeaderboard        728x90      IAB leaderboard         Tablets
        // kGADAdSizeSmartBannerPortrait / kGADAdSizeSmartBannerLandscape
        //              Screen width x 32|50|90     Smart banner            Phones and tablets
        // 自訂尺寸 let adSize = GADAdSizeFromCGSize(CGSize(width: 300, height: 50))
        //      Provided width x Adaptive height    Adaptive banner Phones and Tablets
        // -----------------------------------------------------------------------------------
        let adView = GADBannerView(adSize: kGADAdSizeBanner)

        adView.backgroundColor = randomColor()
        
        // 設定廣告ID, delegate, view controller
        adView.adUnitID = "ca-app-pub-2351040660919094/7319797991"
        adView.delegate = self
        adView.rootViewController = self
        // 載入廣告
        adView.load(GADRequest())

        return adView
    }()

    // 將 Status Bar 修改為 light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 主畫面加上漸層背景圖層
        view.addGradientLayer(frame: view.frame)
        if let layer = view.layer.sublayers?[0] as? CAGradientLayer {
            layer.colors = [UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1).cgColor,
                        UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1).cgColor,
                        UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1).cgColor]
        }
        // -----------------------------------------------------------------------------------
        // stackView 包含3個區塊
        //   - applyImageView :
        //   - filterDetailView :
        //   - bannerView : 橫幅 banner 廣告，
        // -----------------------------------------------------------------------------------
        stackView = UIStackView(arrangedSubviews: [applyImageView, gapView, filterDetailView, bannerView])
        stackView.spacing = 0
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

        applyImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -40).isActive = true
        
        gapView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        filterDetailView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        bannerView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        print("view did load \(stackView.frame)")
    }
    
    func randomColor() -> UIColor {
        let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return color
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

// -----------------------------------------------------------------------------------
// 廣告載入監控
// -----------------------------------------------------------------------------------
extension ApplyFilterViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}

// -----------------------------------------------------------------------------------
// 換頁監控
// -----------------------------------------------------------------------------------
extension ApplyFilterViewController: ApplyImageViewDelegate {
    func backToMain() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func goPublishPage() {
        let nextStoryboard = UIStoryboard(name: "Publish", bundle: nil)
        if let nextController = nextStoryboard.instantiateViewController(withIdentifier: "Publish") as? PublishViewController {
            self.present(nextController, animated: true, completion: nil)
        }
    }
    
    func goFilterListPage() {
        let nextStoryboard = UIStoryboard(name: "ShowSelectFilter", bundle: nil)
        if let nextController = nextStoryboard.instantiateViewController(withIdentifier: "ShowSelectFilter") as? ShowSelectFilterViewController {
            self.present(nextController, animated: true, completion: nil)
        }
    }
}

// -----------------------------------------------------------------------------------
// 新增或移除濾鏡監控
// -----------------------------------------------------------------------------------
extension ApplyFilterViewController: AddOrRemoveFilterDelegate {
    func addFilter(categoryName: String, filterName: String) {
        print("add filter: \(categoryName)  \(filterName)")
        filterDetailView.changeDisplay()
        filterDetailView.popUpAttributeView(isPop: true)
    }
    
    func removeFilter(filterName: String) {
        print("revmoe filter: \(filterName)")
        filterDetailView.changeDisplay()
        //filterDetailView.popUpAttributeView(isPop: false)
    }
}
