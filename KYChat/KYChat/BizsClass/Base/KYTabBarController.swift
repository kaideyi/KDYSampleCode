//
//  KYTabBarController.swift
//  KYChat
//
//  Created by KYCoder on 2017/8/30.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class KYTabBarController: UITabBarController {

    // MARK:
    
    // 默认播放声音的间隔
    let kDefaultPlaySoundInterval = 3.0
    var lastPlaySoundDate: Date = Date()
    
    let conversationVC = KYConversationController()
    let contactVC = KYContactsController()
    let meVC = KYMeViewController()
    
    var connectionState: EMConnectionState = EMConnectionConnected
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        
        setupUnReadMessages()
        setupUntreatedApplys()

        setupNotifications()
        
        KYChatHelper.share.contactVC = contactVC
        KYChatHelper.share.conversationVC = conversationVC
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(kUnReadMessagesNoti), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(kUTreatApplysNoti), object: nil)
    }
    
    func setupViewControllers() {
        let titleArray = ["会话", "通讯录", "我"]
        
        let imagesNormal = [
            KYAsset.TabChatNormal.image,
            KYAsset.TabContactsNormal.image,
            KYAsset.TabMeNormal.image
        ]
        
        let imagesSelect = [
            KYAsset.TabChatSelect.image,
            KYAsset.TabContactsSelect.image,
            KYAsset.TabMeSelect.image
        ]
        
        let controllers = [conversationVC, contactVC, meVC]
        var navigationControllers: [KYNavigationController] = []
        
        for (index, controller) in controllers.enumerated() {
            controller.title = titleArray[index]
            controller.tabBarItem.title = titleArray[index]
            
            if let imageNormal = imagesNormal[index],
                let imageSelect = imagesSelect[index] {
                controller.tabBarItem.image = imageNormal.withRenderingMode(.alwaysOriginal)
                controller.tabBarItem.selectedImage = imageSelect.withRenderingMode(.alwaysOriginal)
            }
            
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: .normal)
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: KYColor.TabbarSelectedText.color], for: .selected)
            
            let navigation = KYNavigationController(rootViewController: controller)
            navigationControllers.append(navigation)
        }
        
        self.viewControllers = navigationControllers as [KYNavigationController]
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(setupUnReadMessages), name: NSNotification.Name(kUnReadMessagesNoti), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupUnReadMessages), name: NSNotification.Name(kUTreatApplysNoti), object: nil)
    }
    
    // MARK: - Public Methods
    
    func setupUnReadMessages() {
        if let conversations = EMClient.shared().chatManager.getAllConversations() as? [EMConversation] {
            if conversations.count == 0 { return }
            
            var unReadCounts: Int32 = 0
            for conversation in conversations {
                unReadCounts += conversation.unreadMessagesCount
            }
            
            if unReadCounts > 0 {
                conversationVC.tabBarItem.badgeValue = String("\(unReadCounts)")
            } else {
                conversationVC.tabBarItem.badgeValue = nil
            }
    
            UIApplication.shared.applicationIconBadgeNumber = Int(unReadCounts)
        }
    }

    func setupUntreatedApplys() {
        
    }
    
    func setupNetworkState(_ state: EMConnectionState) {
        connectionState = state
        conversationVC.networkIsConnected()
    }
    
    // 播放声音或振动(有新消息时)
    func playSoundAndVibration() {
        let timeInterval: TimeInterval = Date().timeIntervalSince(self.lastPlaySoundDate)
        if timeInterval < kDefaultPlaySoundInterval {
            // 如果距离上次响铃和震动时间太短, 则跳过响铃
            print("skip ringing & vibration \(Date()), \(self.lastPlaySoundDate)")
            return;
        }
        
        self.lastPlaySoundDate = Date()
        
        EMCDDeviceManager.sharedInstance().playNewMessageSound()
        EMCDDeviceManager.sharedInstance().playVibration()
    }
    
    func showNotification(withMessage message: EMMessage) {
        
    }
}
