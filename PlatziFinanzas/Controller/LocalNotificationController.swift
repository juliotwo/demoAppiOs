//
//  LocalNotificationController.swift
//  DemoApp
//
//  Created by julio vargas bautista on 8/6/19.
//  Copyright © 2019 Platzi. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationController {
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (succes, error) in
            if succes{
                self.addNotifications()
            }
        }
    }
    func addNotifications() {
         let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Hiciste alguna compra el dia de hoy"
        content.body = "Recuerda agregar gastos del dia de hoy"
        content.sound = UNNotificationSound.default
        var date = DateComponents()
        date.hour = 12
        date.minute = 42
        date.timeZone = .current
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
       
        let request = UNNotificationRequest(identifier: "inteensseconds", content: content, trigger: trigger)
        center.add(request) { (error) in
            guard let error = error else{
                return
            }
            print(error.localizedDescription)
        }
    }
}
