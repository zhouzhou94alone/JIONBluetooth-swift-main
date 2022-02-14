//
//  ConstParameter.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/18.
//

import Foundation
import Hue
import SnapKit
import Toast_Swift


let AppWindow = UIApplication.shared.keyWindow


let kAppDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate


let kScreenWidth = UIScreen.main.bounds.width

let kScreenHeight = UIScreen.main.bounds.height

let kDevice_Is_iPhoneXSeries:Bool = UIApplication.shared.statusBarFrame.size.height > CGFloat(20.0)

let kStatusBarHeight:CGFloat = UIApplication.shared.statusBarFrame.height

let kTabBarHeight:CGFloat = kDevice_Is_iPhoneXSeries ? 83.0 : 49.0

let kNavBarHeight:CGFloat = kDevice_Is_iPhoneXSeries ? 44+kStatusBarHeight : 64.0

let kIphoneX_Status_Header:CGFloat = kDevice_Is_iPhoneXSeries ? 24 : 0

let kBottomHeight:CGFloat = kDevice_Is_iPhoneXSeries ? 34.0 : 0.0


//MARK:- color
let kDarkColor = UIColor(hex: "#333333")
let kThemeColor = UIColor(hex: "#BF3939")

let kbgGrayColor = UIColor(hex: "#f8f8f8")
let kGrayColor = UIColor(hex: "#999999")


//Mark:Noti
let kVersionUpdate = "version.update"
let kCommandSuccess = "command.success"
let kAgainVersionUpdate = "againVersion.update"
