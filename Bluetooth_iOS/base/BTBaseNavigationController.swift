//
//  BTBaseNavigationController.swift
//  Bluetooth_iOS
//
//  Created by JION_ZHOU on 2021/3/18.
//

import UIKit

class BTBaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = kDarkColor
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for: .default)
    }
    
}
