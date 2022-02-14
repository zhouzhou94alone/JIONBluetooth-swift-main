//
//  BTAlertOpenDeviceViewController.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/19.
//

import UIKit
//import SwiftDate

class BTAlertOpenDeviceViewController: BTBaseViewController, BluetoothMangerDelegate {
   
    
   var isHomePagePush = false
   let blueManger = BluetoothManger.shared
    lazy var titleBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    lazy var searchBtn1: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    lazy var handImgV1: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    lazy var searchBtn2: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    lazy var handImgV2: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    lazy var oneDeviceSuccessView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var twoDeviceSuccessView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        //搜索蓝牙
        blueManger.isConnection = true
        blueManger.delegate = self
        blueManger.discoverDeivice()
        
        self.addNoti()
        // Do any additional setup after loading the view.
    }
    //MARK: - noti
    private func addNoti() {
        NotificationCenter.default.addObserver(self, selector: #selector(nofikVersionUpdate(_:)), name: Notification.Name(kVersionUpdate), object: nil)
    }
    @objc func nofikVersionUpdate(_ noti:Notification) {
        self.deviceAry()
    }
    deinit {
      //  ZLPhotoConfiguration.default().selectModels.removeAll()
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: - UI
    private func initUI() {
        let logoheight = (kScreenWidth-20)*0.37
        
        let headerView = UIView()
        self.view.addSubview(headerView)
        headerView.backgroundColor = kbgGrayColor
        headerView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(logoheight+kNavBarHeight)
        }
        
        let logoimageV = UIImageView()
        headerView.addSubview(logoimageV)
        logoimageV.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(kNavBarHeight)
            make.height.equalTo(logoheight)
        }
        logoimageV.image = UIImage(named: "LOGO_03")
        logoimageV.contentMode = .scaleAspectFit
    
        self.view.addSubview(titleBtn)
        titleBtn.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(35)
        }
        titleBtn.titleLabel!.font = UIFont.PingFangSCBoldOFSize(size: 18)
        titleBtn.setTitle("Press the power button on the Device", for: .normal)
        titleBtn.setTitleColor(kDarkColor, for: .normal)
        titleBtn.titleLabel?.numberOfLines = 0
//        titleBtn.textAlignment = .center
        titleBtn.setImage(UIImage(named: ""), for: .normal)
        titleBtn.setImage(UIImage(named: "open_suceces"), for: .selected)
        
        self.view.addSubview(searchBtn1)
        searchBtn1.snp.makeConstraints { (make) in
            make.top.equalTo(titleBtn.snp.bottom).offset(20)
            make.width.height.equalTo(180)
            make.centerX.equalToSuperview()
        }
        searchBtn1.imageView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        searchBtn1.imageView?.contentMode = .scaleAspectFit
        searchBtn1.setImage(UIImage(named: "open_btn"), for: .normal)
        searchBtn1.setImage(UIImage(named: "open_btnBright"), for: .selected)
//        searchBtn.backgroundColor = .red
        searchBtn1.addUp { (btn) in
            if !btn!.isSelected {
                let blueManger = BluetoothManger.shared
                blueManger.isConnection = true
                blueManger.discoverDeivice()
            }
        }
        
        self.view.addSubview(handImgV1)
        handImgV1.snp.makeConstraints { (make) in
            make.left.equalTo(kScreenWidth/2-10)
            make.centerY.equalTo(searchBtn1.snp.centerY).offset(180/2-10)
            make.width.height.equalTo(180)
        }
        handImgV1.image = UIImage(named: "open_hand")
        
        if isHomePagePush {
            
//            searchBtn1.snp.updateConstraints { (make) in
//                make.top.equalTo(titleBtn.snp.bottom).offset(10)
//            }
            
            self.view.addSubview(searchBtn2)
            searchBtn2.snp.makeConstraints { (make) in
                make.top.equalTo(searchBtn1.snp.bottom).offset(10)
                make.width.height.equalTo(180)
                make.centerX.equalToSuperview()
            }
            searchBtn2.imageView?.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
            searchBtn2.imageView?.contentMode = .scaleAspectFit
            searchBtn2.setImage(UIImage(named: "open_btn"), for: .normal)
            searchBtn2.setImage(UIImage(named: "open_btnBright"), for: .selected)
    //        searchBtn.backgroundColor = .red
            searchBtn2.addUp { (btn) in
                if !btn!.isSelected {
                    let blueManger = BluetoothManger.shared
                    blueManger.isConnection = true
                    blueManger.discoverDeivice()
                }
            }
            
            self.view.addSubview(handImgV2)
            handImgV2.snp.makeConstraints { (make) in
                make.left.equalTo(kScreenWidth/2-10)
                make.centerY.equalTo(searchBtn2.snp.centerY).offset(180/2-10)
                make.width.height.equalTo(180)
            }
            handImgV2.image = UIImage(named: "open_hand")
            
            self.findDevice()
        }
        
        if self.isHomePagePush && blueManger.deviceAry.count == 2 {
            self.twoDeviceSuccesUI()
        }
    }
    
    private func oneDeviceSuccesUI() {
        self.view.addSubview(oneDeviceSuccessView)
        oneDeviceSuccessView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(searchBtn1.snp.bottom)
            make.bottom.equalTo(0)
        }
        
       
        let lineView = UIImageView()
        oneDeviceSuccessView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(180)
        }
        lineView.contentMode = .scaleAspectFill
        lineView.image = UIImage(named: "icon_vertical")
        
        let phoneImgV = UIImageView()
        oneDeviceSuccessView.addSubview(phoneImgV)
        phoneImgV.snp.makeConstraints { (make) in
            make.top.equalTo(lineView.snp.bottom)
            make.width.equalTo(300)
            make.height.equalTo(369)
            make.centerX.equalToSuperview()
        }
        phoneImgV.image = UIImage(named: "phone")
        phoneImgV.contentMode = .scaleAspectFit
        
    }
    
    private func twoDeviceSuccesUI() {
        
        searchBtn1.isHidden = true
        searchBtn2.isHidden = true
        handImgV1.isHidden = true
        handImgV2.isHidden = true
        
        self.view.addSubview(twoDeviceSuccessView)
        twoDeviceSuccessView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(titleBtn.snp.bottom).offset(20)
            make.bottom.equalTo(0)
        }
        
        let imgV1 = UIImageView()
        twoDeviceSuccessView.addSubview(imgV1)
        imgV1.snp.makeConstraints { (make) in
            make.width.height.equalTo(180)
            make.centerX.equalToSuperview().offset(-180/2-5)
            make.top.equalTo(0)
        }
        imgV1.image = UIImage(named: "open_btnBright")
        
        let imgV2 = UIImageView()
        twoDeviceSuccessView.addSubview(imgV2)
        imgV2.snp.makeConstraints { (make) in
            make.width.height.equalTo(180)
            make.left.equalTo(imgV1.snp.right).offset(10)
            make.top.equalTo(0)
        }
        imgV2.image = UIImage(named: "open_btnBright")
        
        
     
        let lineView1 = UIImageView()
        twoDeviceSuccessView.addSubview(lineView1)
        lineView1.snp.makeConstraints { (make) in
            make.top.equalTo(imgV1.snp.bottom)
            make.centerX.equalTo(imgV1.snp.centerX).offset(50)
            make.width.equalTo(95)
            make.height.equalTo(180)

        }
        lineView1.contentMode = .scaleAspectFit
        lineView1.image = UIImage(named: "icon_left_connect")
        
        let lineView2 = UIImageView()
        twoDeviceSuccessView.addSubview(lineView2)
        lineView2.snp.makeConstraints { (make) in
            make.top.equalTo(imgV1.snp.bottom)
            make.left.equalTo(lineView1.snp.right).offset(0)
            make.width.equalTo(95)
            make.height.equalTo(180)

        }
        lineView2.contentMode = .scaleAspectFit
        lineView2.image = UIImage(named: "icon_right_connect")
        
//        lineView1.backgroundColor = .red
//        lineView2.backgroundColor = .red
        
        let phoneImgV = UIImageView()
        twoDeviceSuccessView.addSubview(phoneImgV)
        phoneImgV.snp.makeConstraints { (make) in
            make.top.equalTo(lineView1.snp.bottom)
            make.width.equalTo(300)
            make.height.equalTo(369)
            make.centerX.equalToSuperview()
        }
        phoneImgV.image = UIImage(named: "phone")
        phoneImgV.contentMode = .scaleAspectFit
        
    }
    //MARK:BluetoothMangerDelegate
    func deviceAry() {
        if blueManger.deviceAry.count > 0 {
            
            
            var model:BTBlueDeviceInfoModel!
            if blueManger.deviceAry.count == 1 {
                model = blueManger.deviceAry[0]
                self.oneDeviceSuccesUI()
            }else if blueManger.deviceAry.count == 2{
                model = blueManger.deviceAry[1]
                self.twoDeviceSuccesUI()
            }
            
            titleBtn.isSelected = true
            titleBtn.setTitle(model.name+" successfully paired", for: .selected)
            
            let topVC = AppInfo.getTopVC()
            if topVC?.classForCoder != BTAlertOpenDeviceViewController.classForCoder() {
                return
            }
            
            let alert = UIAlertController(title: model.name+" successfully paired", message:nil, preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Cancel", style: .default) { [weak self] (_) in
                //设备关机
                self?.blueManger.whiteCommand(model: model,command: "AT+QPOWD")
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action1)
            let action = UIAlertAction(title: "Next", style: .default) { [weak self] (_) in

                self?.blueManger.whiteCommand(model: model,command: model.colorCommand)

            
                
            }
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
           
        }
    }
    
    func findDevice(){
        if blueManger.deviceAry.count == 1 {
            searchBtn1.isSelected = true
            handImgV1.isHidden = true
            searchBtn2.isSelected = false
            handImgV2.isHidden = false
        }else if blueManger.deviceAry.count == 2 {
            searchBtn1.isSelected = true
            handImgV1.isHidden = true
            searchBtn2.isSelected = true
            handImgV2.isHidden = true
        }
      
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
