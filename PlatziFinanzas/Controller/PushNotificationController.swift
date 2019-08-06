//
//  PushNotificationController.swift
//  DemoApp
//
//  Created by julio vargas bautista on 8/6/19.
//  Copyright © 2019 Platzi. All rights reserved.
//


import UIKit
import UserNotifications
import FirebaseMessaging

class PushNotificationsController: NSObject {
    
    init(application: UIApplication) {
        super.init()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (success, error) in
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
        
        Messaging.messaging().delegate = self
    }
    
    func addDeviceToken(_ token: Data) {
        Messaging.messaging().apnsToken = token
    }
}


extension PushNotificationsController: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registring token \(fcmToken)")
        
        let data: [String: String] = ["token": fcmToken]
    }
}
