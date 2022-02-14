//
//  BTBlueDeviceInfoModel.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/20.
//

import UIKit
import CoreBluetooth

class BTBlueDeviceInfoModel: NSObject {
    var uuid = "" //设备id
    var name = "" //暂定前端设置 JION_ZHOU DEVICE A,JION_ZHOU DEVICE B
    var realName = "" //设备名称

    var state:CBPeripheralState = .disconnected
    
    var isReconnectThe = false //是否在重新连接
    var reconnectAlert = UIAlertController()
    
    var isSelect = false
    var peripheral: CBPeripheral? //外设对象
    var characteristic:CBCharacteristic? //外设服务的特征
    
    var timeMin = 20 //默认20分钟
    var power = 1 //默认
    var realPower = 1 //默认
    var isBegin = false //是否开始模式
    var timeIngSec = 20*60
    var isLock = false
    
    var colorCommand = "" //设备闪烁灯颜色命令
    
  
}
