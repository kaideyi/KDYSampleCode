//
//  ViewController.swift
//  KYPlayer
//
//  Created by mac on 17/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "播放器"
        self.view.backgroundColor = .white
        
        let playerController = KYPlayerViewController()
        playerController.view.bounds = self.view.bounds
        self.addChildViewController(playerController)
        
        self.view.addSubview(playerController.view)
        playerController.didMove(toParentViewController: self)
    }
}

