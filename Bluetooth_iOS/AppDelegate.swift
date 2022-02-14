//
//  AppDelegate.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/18.
//

import UIKit
import Toast_Swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        self.loadModules()
        
        self.toastConfig()
        
        //创建中心管理者
        BluetoothManger.shared.createCentralManager()
        return true
    }
    //MARK: - 加载
    func loadModules() {
        //新用户引导图
        loadGuideModule()
    }
    
    func loadGuideModule(){
      
        let guideVC = BTStartViewController()
//        let guideVC = BTHomeViewController()
        
        let nav = BTBaseNavigationController(rootViewController: guideVC)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    private func toastConfig() {
        var style = ToastStyle()
        style.cornerRadius = 5
        style.backgroundColor = UIColor.black.alpha(0.8)
        style.horizontalPadding = 15
        style.verticalPadding = 15
        style.shadowRadius = 8
        style.shadowColor = UIColor(hex: "#1D1E20")
        style.shadowOffset = .zero
        style.fadeDuration = 0.5
        style.shadowOpacity = 0.04
        ToastManager.shared.position = .center
        ToastManager.shared.style = style
        ToastManager.shared.duration = 1
        ToastManager.shared.isTapToDismissEnabled = false
    }
    
    
    
    
    
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//

}

