//
//  BluetoothManger.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/20.
//

import UIKit
import CoreBluetooth
public enum CommandType: Int {
    ///命令类型
    case none = 0
    case model = 1//A．模式命令
    case pause = 2 //暂停
    case power = 3 //强度
    case powerQuery = 4 //强度查询
    case time = 5 //设置倒计时
    case query = 6 //其他查询
}

@objc protocol BluetoothMangerDelegate:NSObjectProtocol {
//    @objc optional func commandSuccess(commandType:Int)
//    @objc optional func deviceAry(array:Array<BTBlueDeviceInfoModel>)
    @objc optional func findDevice()
}

class BluetoothManger: NSObject,CBCentralManagerDelegate, CBPeripheralDelegate {
    
    weak var delegate:BluetoothMangerDelegate?
    
    static let shared = BluetoothManger()
    
    var commandType:CommandType = .none
    
//    CBCentralManager - 中心管理者
//    CBPeripheralManager - 外设管理者
//    CBPeripheral - 外设对象
//    CBService - 外设服务
//    CBCharacteristic - 外设服务的特征

    
    var centralManager:CBCentralManager! //中心管理者
//    private var peripheralManager:CBPeripheralManager!//外设管理者
    private var peripheral: CBPeripheral? //外设对象
    

    
    var deviceAry = Array<BTBlueDeviceInfoModel>()

    var isConnection = false //是否给出提示框
    
    
    var modelQuery:((_ index:Int) ->Void)? //模式查询
    var countdownTimeQuery:((_ time:String) ->Void)? //倒计时查询
    
    //创建蓝牙中心管理者
    func createCentralManager(){
        if self.centralManager == nil {
            self.centralManager = CBCentralManager.init(delegate: self, queue: .main)
        }
    }
    //搜索蓝牙设备
    func discoverDeivice(){
        if centralManager.state == .unknown {
            let alert = UIAlertController(title: "JION_ZHOU would like to use Bluetooth", message:"This app controls your device using Bluetooth", preferredStyle: .alert)
            let action = UIAlertAction(title: "Settings", style: .default) { (_) in
                //打开设置界面
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 11.0, *){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            alert.addAction(action)
            let topVC = AppInfo.getTopVC()
            topVC!.present(alert, animated: true, completion: nil)
            return
        }
        if centralManager.state == .poweredOn {
            //开始搜索
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
       

    }
    
    ///MARK:CBCentralManagerDelegate
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
               case .unknown:
                   print("未知的")
               case .resetting:
                   print("重置中")
               case .unsupported:
                   print("不支持")
               case .unauthorized:
                   print("未验证")
               case .poweredOff:
                   print("未启动")
               case .poweredOn:
                   print("可用")
//                   // 创建Service（服务）和Characteristics（特征）
//                   setupServiceAndCharacteristics()
//                   // 根据服务的UUID开始广播
//                   self.peripheralManager?.startAdvertising([CBAdvertisementDataServiceUUIDsKey : [CBUUID.init(string: Service_UUID)]])
                
        @unknown default: break
            
        }
    }
    ///发现符合要求的外设
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        print("peripheral:"+peripheral)
        if peripheral.name != nil {
            if (peripheral.name?.hasPrefix("Domas"))! {
                print("name:====="+peripheral.name!)
                if isConnection {
                    self.peripheral = peripheral
                    var name = ""
                    if self.deviceAry.count == 0 {
                        name = "JION_ZHOU DEVICE A"
                    }else  if self.deviceAry.count == 1 {
                        let model = self.deviceAry[0]
                        if model.name == "JION_ZHOU DEVICE A" {
                            name = "JION_ZHOU DEVICE B"
                        }else{
                            name = "JION_ZHOU DEVICE B"
                        }
                    }
                    let alert = UIAlertController(title: name+" was found", message:nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
                    }
                    alert.addAction(action)
                    let action1 = UIAlertAction(title: "Pair", style: .default) { (_) in
                        if  self.peripheral!.state == .connected ||  self.peripheral!.state == .connecting{
                            self.centralManager(central, didConnect:  self.peripheral!)
                        }else{
                            //连接设备
                            //CBConnectPeripheralOptionNotifyOnDisconnectionKey true 如果想要系统在指定的周边设备在app挂起状态期间断开连接时显示一个alter提示，就使用这个key值。
                            central.connect( self.peripheral!, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey : true])
                        }
                        
                    }
                    alert.addAction(action1)
                    let topVC = AppInfo.getTopVC()
                    topVC!.present(alert, animated: true, completion: nil)
                    isConnection = false
                    if self.delegate != nil {
                        self.delegate?.findDevice!()
                    }
                }else{
                    for model in self.deviceAry {
                        if model.realName == peripheral.name && model.isReconnectThe{
                            central.connect( self.peripheral!, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey : true])
                        }
                    }
                }
              

            }
        }
       
        
    }
    ///连接成功  连接成功后让中心设备停止扫描节约电
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接成功")
        var deviceModel:BTBlueDeviceInfoModel!
        for model in self.deviceAry {
            if model.uuid == peripheral.identifier.uuidString {
                deviceModel = model
                model.state = peripheral.state
                model.peripheral = peripheral
            }
        }
        if deviceModel == nil && self.deviceAry.count < 2{
            for model in self.deviceAry {
                model.isSelect = false
            }
            deviceModel = BTBlueDeviceInfoModel()
            deviceModel.uuid = peripheral.identifier.uuidString
            deviceModel.realName = peripheral.name!
            deviceModel.state = peripheral.state
            deviceModel.isSelect = true
            if self.deviceAry.count == 0 {
                deviceModel.name = "JION_ZHOU DEVICE A"
                deviceModel.colorCommand = "AT+CTE=1,0" //红色灯命令
            }else  if self.deviceAry.count == 1 {
                let model = self.deviceAry[0]
                if model.name == "JION_ZHOU DEVICE A" {
                    deviceModel.name = "JION_ZHOU DEVICE B"
                    deviceModel.colorCommand = "AT+CTE=1,3"//绿色灯命令
                }else{
                    deviceModel.name = "JION_ZHOU DEVICE A"
                    deviceModel.colorCommand = "AT+CTE=1,0"//红色灯命令
                }
                
            }
            deviceModel.peripheral = peripheral
            self.deviceAry.append(deviceModel)
        }
        self.centralManager?.stopScan()
        deviceModel.peripheral!.delegate = self
        //搜索指定服务
//        peripheral.discoverServices([CBUUID.init(string: deviceModel.uuid)])
        //搜索外设的所有服务（默认所有服务）
        deviceModel.peripheral!.discoverServices(nil)

       
        if deviceModel.isReconnectThe == true {

        }else{
            updateAry()
        }
    }
    ///连接失败的回调
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接失败")
        
    }
    /** 断开连接 */
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("断开连接")
        
        var isOld = false
        for model in self.deviceAry {
            if model.isReconnectThe{
                isOld = true
                break
            }
        }
        //已经有正在重新连接的设备了，直接删除
        if isOld {
            for model in self.deviceAry {
                if model.uuid == peripheral.identifier.uuidString {
                    self.deviceAry.removeAll(where: { $0 == model})
                    if self.deviceAry.count == 1 {
                        AppWindow!.makeToast(model.name+" Bluetooth connection has been disconnected！")
                        let model = self.deviceAry[0]
                        model.isSelect = true
                    }
                    self.updateAry()
                }
            }
           
            return
        }
        
        
        for model in self.deviceAry {
            if model.uuid == peripheral.identifier.uuidString {
                
               
                let alert = UIAlertController(title: model.name+" Bluetooth connection has been disconnected", message:nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "Know the", style: .cancel) { (_) in
                    self.deviceAry.removeAll(where: { $0 == model})
                    if self.deviceAry.count == 1 {
                        AppWindow!.makeToast(model.name+" Bluetooth connection has been disconnected！")
                        let model = self.deviceAry[0]
                        model.isSelect = true
                    }
                    self.updateAry()
                }
                alert.addAction(action)
                let action1 = UIAlertAction(title: "Reconnect the", style: .default) { (_) in
                    print("重新连接")
                    model.isReconnectThe = true
                    self.discoverDeivice()
                    
                    //给出一个加载框
                    let alert1 = UIAlertController(title: "Reconnection in progress", message:"Please turn on device bluetooth", preferredStyle: .alert)
                    
                    alert1.addTextField { (textview) in
                        textview.isUserInteractionEnabled = false
                        textview.borderStyle = .none
                        
                        textview.superview!.superview!.isHidden = true

                        let indictor = UIActivityIndicatorView(style: .gray)
                        textview.superview!.superview!.superview!.addSubview(indictor)
                        indictor.snp.makeConstraints { (make) in
                            make.width.height.equalTo(15)
                            make.centerY.equalToSuperview()
                            make.centerX.equalToSuperview()
                        }
                        indictor.startAnimating()
                        
                    }
                    let action = UIAlertAction(title: "cancel", style: .cancel) { (_) in
                        self.deviceAry.removeAll(where: { $0 == model})
                        if self.deviceAry.count == 1 {
                            AppWindow!.makeToast(model.name+" Bluetooth connection has been disconnected！")
                            let model = self.deviceAry[0]
                            model.isSelect = true
                        }
                        self.updateAry()
                    }
                    alert1.addAction(action)

                    let topVC = AppInfo.getTopVC()
                    topVC!.present(alert1, animated: true, completion: nil)
                    model.reconnectAlert = alert1
                }
                alert.addAction(action1)
                let topVC = AppInfo.getTopVC()
                topVC!.present(alert, animated: true, completion: nil)
                
                break
            }
        }
    }
   
    
    
    //MARK:CBPeripheralDelegate
    ///发现服务
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service: CBService in peripheral.services! {
            print("外设中的服务有：\(service)")
        }
//        if peripheral.services!.count > 0 {
//            //本例的外设中只有一个服务
//            let service = peripheral.services?.first
//            let uuid = service?.uuid.uuidString
//            // 根据UUID寻找服务中的特征
//            peripheral.discoverCharacteristics([CBUUID.init(string: uuid!)], for: service!)
//        }
//
        peripheral.services?.forEach{
                   //搜索所有的设备特征
                   peripheral.discoverCharacteristics(nil, for: $0)}
      
    }
    ///发现特征
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
                
//                self.characteristic = service.characteristics?.last
//                // 读取特征里的数据
//                peripheral.readValue(for: self.characteristic!)
//                // 订阅
//                peripheral.setNotifyValue(true, for: self.characteristic!)
        service.characteristics?.forEach {
            //properties
            //订阅所有的特征
            if $0.properties == .notify{
                // 直接读取这个特征数据 会调用didUpdateValueForCharacteristic
                peripheral.readValue(for: $0)
                // 订阅通知
                peripheral.setNotifyValue(true, for: $0)
              
             
            }
        }
        for characteristic: CBCharacteristic in service.characteristics! {
            if characteristic.uuid.uuidString == "FFF5" {
     
                var isOld = false
                for model in self.deviceAry {
                    if model.realName == peripheral.name && model.isReconnectThe{
                        isOld = true
                        print("重新连接成功")
                        AppWindow!.makeToast(model.name+" Reconnect successfully！")
                        model.characteristic = characteristic
                        model.isReconnectThe = false
                        NotificationCenter.default.post(name: Notification.Name(kAgainVersionUpdate), object: model)
                        model.reconnectAlert.dismiss(animated: true, completion: nil)
                        break
                    }
                }
                if !isOld {
                    if self.deviceAry.count == 1 {
                        let model = self.deviceAry[0]
                        model.characteristic = characteristic
                    }else if self.deviceAry.count == 2 {
                        let model = self.deviceAry[1]
                        model.characteristic = characteristic
                        
                    }
                }
               
            }
            print("外设中的特征有：\(characteristic)")
        }
    }
   
    ///订阅状态
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("订阅失败: \(error)")
            return
        }
        if characteristic.isNotifying {
            print("订阅成功 uuid:"+characteristic.uuid.uuidString)
//            peripheral.readValue(for: characteristic)
            
        } else {
            print("取消订阅")
        }
    }
    /// 收到外设发送内容
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let data = characteristic.value
        if data != nil {
            if let datastr = String.init(data: data!, encoding: String.Encoding.utf8) {
                print("收到外设发送的数据"+"\(datastr )")
             
            }
        }
        
    }
    ///写入数据
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        print("写入数据")
    }
    
    func whiteCommand(model:BTBlueDeviceInfoModel,command:String){
        print("执行命令："+command)
        if model.characteristic != nil {
            
            ///两种方式
            //第一种：直接UTF-8
//           let data = command.data(using: String.Encoding.utf8)

            //第二种：换字节
            var getbytes :[UInt8]  = []

            let mydata = command.data(using: String.Encoding.utf8)
            let bytes1 = [UInt8](mydata!)
            getbytes.append(contentsOf: bytes1)

            //字符 \n
            let getbytes1 :[UInt8] = [0x5C,0x6E]
            getbytes.append(contentsOf: getbytes1)
            
            let data = Data(bytes: getbytes, count: getbytes.count)
        
            model.peripheral?.writeValue(data, for: model.characteristic!, type: .withResponse)


        }else{
            print("外设服务为nil")
        }
        
    }
    

    
    
    
   ///数组更新
    func updateAry(){
        NotificationCenter.default.post(name: Notification.Name(kVersionUpdate), object: nil)

    }
}
