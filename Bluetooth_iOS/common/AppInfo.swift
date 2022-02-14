//
//  AppInfo.swift
//  JION_ZHOU_iOS
//
//  Created by JION_ZHOU on 2020/10/22.
//  Copyright © 2020 JION_ZHOU. All rights reserved.
//

import Foundation

class AppInfo {
    
    //获取文档路径
    static func documentPath() ->String {
        let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).last! as String
        return documentPath
    }
    
    //获取缓存路径
    static func cachePath() ->String {
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as String
        return cachePath
    }
    
    //获取版本号
    static func getVersionCode() ->Int {
        let version = getVersion()
        let code = version.replacingOccurrences(of: ".", with: "")
        return Int(code) ?? 0
    }
    
    //获取版本
    static func getVersion() ->String {
        return  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    
    //获取名称
    static func getAppName() ->String {
        return  Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    //获取uuid
//    static func getUUID() ->String {
//        return FCUUID.uuidForSession()
//    }
    
    static func getTopVC() -> UIViewController? {
        let rootVC = kAppDelegate.window?.rootViewController
        return getCurrentVC(from: rootVC)
    }
    
    private static func getCurrentVC(from rootVC:UIViewController?) ->UIViewController? {
        guard let nextVC = rootVC?.presentedViewController else {
            if rootVC is UITabBarController {
                let tabbarVC = rootVC as! UITabBarController
                let nextRootVC = tabbarVC.selectedViewController
                return getCurrentVC(from: nextRootVC)
            }
            if rootVC is UINavigationController {
                let naviVC = rootVC as! UINavigationController
                let visibleVC = naviVC.visibleViewController
                return getCurrentVC(from: visibleVC)
            }
            return rootVC
        }
        return getCurrentVC(from: nextVC)
    }
}
