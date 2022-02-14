//
//  BTWelcomeViewController.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/19.
//

import UIKit
import CoreBluetooth

class BTWelcomeViewController: BTBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
        // Do any additional setup after loading the view.
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
        
        let titleLB = UILabel()
        self.view.addSubview(titleLB)
        titleLB.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.left.right.equalTo(0)
            make.height.equalTo(35)
        }
        titleLB.font = UIFont.PingFangSCBoldOFSize(size: 22)
        titleLB.text = "Welcome to Jon"
        titleLB.textAlignment = .center
        
        let contentLB = UILabel()
        self.view.addSubview(contentLB)
        contentLB.snp.makeConstraints { (make) in
            make.top.equalTo(titleLB.snp.bottom).offset(10)
            make.left.equalTo(50)
            make.right.equalTo(-50)
//            make.height.equalTo(40)
        }
        contentLB.numberOfLines = 0
        contentLB.font = UIFont.PingFangSCRegularOFSize(size: 14)
        contentLB.text = "yes"
        contentLB.textAlignment = .center
        
        let searchBtn = UIButton()
        self.view.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(contentLB.snp.bottom).offset(80)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(150)
        }
        searchBtn.imageView?.contentMode = .scaleAspectFill
        searchBtn.setImage(UIImage(named: "logo2_07"), for: .normal)
        searchBtn.addUp {[weak self] (btn) in
            self?.search()
        }
        searchBtn.setTitle("点我", for: .normal)

    }
    
    private func search(){
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
        let action1 = UIAlertAction(title: "OK", style: .default) { (_) in
            
         

            let vc = BTAlertOpenDeviceViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
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
