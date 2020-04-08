//
//  MyNotificationCenter.swift
//  MyEasyFilter
//
//  Created by Apple on 2020/3/5.
//  Copyright © 2020 Nautilus. All rights reserved.
//

import Foundation

// 使用 Protocol Extension 來擴充NSNUmberInfo, 使所有通知都能共用
protocol NotificationRepresentable {}

// 寫在 Protocol extension 裡的方法會預設套用給所有遵守此 protocol 的型別
extension NotificationRepresentable {
    // 跟通知相關的 key 和 name
    static var notificationName: Notification.Name {
        // 以實際型別的框架 ＋ 名稱來當通知名稱，避免撞名
        return Notification.Name(String(reflecting: Self.self))
    }
    
    static var userInfoKey: String {
        return "UserInfo"
    }
    
    init?(notification: Notification) {
        // 使用 Self 已取得實際上的型別 （套用此協定的型別）
        guard let value = notification.userInfo?[Self.userInfoKey] as? Self else { return nil }
        self = value
    }
}

extension NotificationCenter {
    // 傳送通知用的便利方法
    func addObserver<T>(_ observer: Any, selector: Selector, _ notificationRepresentable: T, object: Any? = nil) where T: NotificationRepresentable {
        addObserver(observer, selector: selector, name: T.notificationName, object: object)
    }
    // T 即是代表實際被送出的型別
    func post<T>(_ notificationRepresentable: T, object: Any? = nil) where T: NotificationRepresentable {
        post(name: T.notificationName, object: object, userInfo: [T.userInfoKey : notificationRepresentable])
    }
}

enum InputEvent: NotificationRepresentable {
    case NSNumberInfo(name: String, value: Float)
    case CIVectorInfo(name: String, x: Float, y: Float, z: Float)
    case CIColorInfo(name: String, r: Float, g: Float, b: Float, a: Float)
}

/*struct NSNumberInfo {
    var name: String
    var value: NSNumber
}

extension NSNumberInfo: NotificationRepresentable { }

extension NSNumberInfo {
    // 把 key 移到 NSNumberInfo 裡作為一個 static var 方便管理
    static var userInfoKey: AnyHashable {
        return "NSNumberInfo"
    }
    
    // 再給 NSNumberInfo 新增一個 static var, 回傳屬於他的通知名稱
    static var notificationName: Notification.Name {
        return .init("FilterChangeEvent")
    }
    
    // 使 NSNumberInfo 可以從一個 Notification 建構出來
    init?(notification: Notification) {
        if let nsNumberInfo = notification.userInfo?[NSNumberInfo.userInfoKey] as? NSNumberInfo {
            self = nsNumberInfo
        }
        else {
            return nil
        }
    }
}

extension NotificationCenter {
    // 發送通知用的便利方法
    func post(nsNumberInfo: NSNumberInfo, object: Any? = nil) {
        post(name: NSNumberInfo.notificationName, object: object, userInfo: [NSNumberInfo.userInfoKey: nsNumberInfo])
    }
 
    func addObserver() {
 
    }
}*/
