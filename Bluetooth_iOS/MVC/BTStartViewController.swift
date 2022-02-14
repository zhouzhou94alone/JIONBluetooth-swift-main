//
//  BTStartViewController.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/18.
//

import UIKit

class BTStartViewController: BTBaseViewController {

    lazy var selectBtn: UIButton = {
        let selectBtn = UIButton()
        return selectBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.initUI()
    
        // Do any additional setup after loading the view.
    }
    // MARK: - UI
    private func initUI() {
        
        
        let startBtn = UIButton()
        self.view.addSubview(startBtn)
        startBtn.snp.makeConstraints { (make) in
            make.left.equalTo(50)
            make.right.equalTo(-50)
            make.height.equalTo(55)
            make.centerY.equalToSuperview()
        }
        startBtn.setTitleColor(kThemeColor, for: .normal)
        startBtn.titleLabel?.font = UIFont.PingFangSCBoldOFSize(size: 18)
        startBtn.layer.cornerRadius = 5
        startBtn.backgroundColor = .white
        startBtn.layer.shadowColor = UIColor(hex: "#BCBABA").alpha(0.6).cgColor
        startBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        startBtn.layer.shadowOpacity = 1.0
        startBtn.layer.shadowRadius = 5;
        startBtn.setTitle("START", for: .normal)
        startBtn.addUp { [weak self](btn) in
            self?.welcome()
        }
        
        let logoimageV = UIImageView()
        self.view.addSubview(logoimageV)
        let logoheight = (kScreenWidth-20)*0.37
        logoimageV.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(startBtn.snp.top).offset(-50)
            make.height.equalTo(logoheight)
        }
        logoimageV.image = UIImage(named: "LOGO_03")
        logoimageV.contentMode = .scaleAspectFit
        
        let useBtn = UIButton()
        self.view.addSubview(useBtn)
        useBtn.snp.makeConstraints { (make) in
            make.top.equalTo(startBtn.snp.bottom).offset(10)
            make.height.equalTo(55)
            make.centerX.equalToSuperview().offset(20)
        }
        useBtn.setTitle("I agree to the terms of use", for: .normal)
        useBtn.setTitleColor(kDarkColor, for: .normal)
        useBtn.titleLabel?.font = UIFont.PingFangSCRegularOFSize(size: 16)
        useBtn.addUp { [weak self] (btn) in
            self?.lookUse()
        }
        
        self.view.addSubview(selectBtn)
        selectBtn.snp.makeConstraints { (make) in
            make.right.equalTo(useBtn.snp.left).offset(-10)
            make.width.height.equalTo(55)
            make.centerY.equalTo(useBtn.snp.centerY)
        }
        selectBtn.imageView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(25)
//            make.right.equalTo(0)
        })
        selectBtn.setImage(UIImage(named: "use_unselect"), for: .normal)
        selectBtn.setImage(UIImage(named: "use_select"), for: .selected)
        selectBtn.contentHorizontalAlignment = .right
        selectBtn.addUp { (btn) in
            btn?.isSelected = !btn!.isSelected
        }
        selectBtn.isSelected = true
    }
    
    private func lookUse(){
        let vc = DJBaseWebViewController()
        vc.myTitle = "Privacy Policy"
        vc.url = "https://baidu.com"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func welcome(){
        if !selectBtn.isSelected {
            self.view.makeToast("Please agree to the terms of use")
            return
        }
        let vc = BTWelcomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
