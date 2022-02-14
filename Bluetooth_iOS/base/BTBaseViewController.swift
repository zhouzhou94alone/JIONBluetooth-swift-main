//
//  BTBaseViewController.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/18.
//

import UIKit


enum Action {
    case back
    case ignore
    case menu
    case more
    case save
    case sure
}



class BTBaseViewController: UIViewController, UIGestureRecognizerDelegate {
   
    
    
    var backBarButtonItem:UIBarButtonItem!
    private  var _myTitle:String?
    var myTitle:String? {
        get {
            return _myTitle
        }set(title) {
            _myTitle = title
            setMyTitle()
        }
    }
    
    private let lab = UILabel()
    //列表刷新某一个cell id作为索引
    var reloadIndexId:((_ result: Any) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        createBackAction()
        
        //启用滑动返回（swipe back）
         self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
    //是否允许手势
      func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
          if (gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer) {
              //只有二级以及以下的页面允许手势返回
              return self.navigationController!.viewControllers.count > 1
          }
          return true
      }
    
    
    
    
    func showTransLusent(isOn:Bool) {
        self.navigationController?.navigationBar.isTranslucent = isOn
    }
    
    func createBackAction() {
        if let vcs = self.navigationController?.viewControllers{
            if vcs.count > 1 {
                backBarButtonItem = createNavItem(nil, "back_black", nil, 0, .back)
                self.navigationItem.leftBarButtonItem = backBarButtonItem
                self.navigationItem.setHidesBackButton(true, animated: false)
                if #available(iOS 11.0, *) {
                    self.navigationItem.backButtonTitle = ""
                } else {
                    // Fallback on earlier versions
                    self.navigationItem.hidesBackButton = true
                }
                self.navigationController?.navigationItem.hidesBackButton = true
            }
        }
    }
    
    //修改标题颜色
    func setTitleColor(_ color:UIColor){
        lab.textColor = color
    }
    
    
    func setMyTitle() {
        if _myTitle?.count == 0 {
            return
        }
        lab.font = UIFont.PingFangSCBoldOFSize(size: 17)
        lab.text = _myTitle
        lab.textColor = kDarkColor
        lab.sizeToFit()
        self.navigationItem.titleView = lab
       // self.title = _myTitle
       // self.navigationController?.title = title
    }
    
    
    
    func createNavItem(_ title:String?,_ imageName:String?,_ titleColor:UIColor?, _ fontSize:CGFloat,_ action:Action) -> UIBarButtonItem{
        let btn = UIButton()
        
        switch action {
        case .back:
            btn.addTarget(self, action: #selector(doBack(_:)), for: .touchUpInside)
        case .ignore:
            btn.addTarget(self, action: #selector(doIgnore(_:)), for: .touchUpInside)
        case .menu:
            btn.addTarget(self, action: #selector(doMenu(_:)), for: .touchUpInside)
        case .more:
            btn.addTarget(self, action: #selector(doMore(_:)), for: .touchUpInside)
        case .save:
            btn.addTarget(self, action: #selector(doSave(_:)), for: .touchUpInside)
        case .sure:
            btn.addTarget(self, action: #selector(doSure(_:)), for: .touchUpInside)
        }
        if imageName != nil {
            btn.setImage(UIImage(named: imageName!), for: .normal)
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        var width:CGFloat = 0.0
        var height:CGFloat = 0.0
        if title != nil {
            btn.sizeToFit()
            width = btn.width + 30.0
            height = btn.height + 30.0
            
        }else {
            guard let image = btn.imageView?.image else {
                btn.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                return UIBarButtonItem.init(customView: btn)
            }
            width = image.size.width + 30.0
            height = image.size.height + 30.0

        }
        btn.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        if action == .back {
            btn.contentHorizontalAlignment = .left
            btn.width =  btn.width-10
        }else{
            btn.contentHorizontalAlignment = .right
        }
        return UIBarButtonItem.init(customView: btn)
    }
    
    //MARK: - action
    @objc func doBack(_ sender:UIButton?) {
        if self.presentingViewController != nil {
            if let nav = self.navigationController {
                if nav.children.count > 1 {
                    self.navigationController?.popViewController(animated: true)
                    return
                }
            }
            self.dismiss(animated: true, completion: nil)
        }else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func doIgnore(_ sender:UIButton?) {
        //TODO:子类重写
    }
    
    @objc func doMenu(_ sender:UIButton?) {
        //TODO:子类重写
    }
    
    @objc func doMore(_ sender:UIButton?) {
        //TODO:子类重写
    }
    
    @objc func doSave(_ sender:UIButton?) {
        //TODO:子类重写
    }
    
    @objc func doSure(_ sender:UIButton?) {
        //TODO:子类重写
    }
    
    
    

    
}
