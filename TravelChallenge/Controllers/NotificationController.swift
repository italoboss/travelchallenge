//
//  NotificationController.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 03/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import Foundation
import UserNotifications


class NotificationController: NSObject, UNUserNotificationCenterDelegate {

    let notificationContents = [NotificationContent.init(title: "Não esqueça de economizar", subtitle: "Mimimi", body: "mimimimimimimimimimimim mimimii"),
                                NotificationContent.init(title: "kajhskjhakjsh", subtitle: "Mimimi", body: "mimimimimimimimimimimim mimimii"),
                                NotificationContent.init(title: "Não esqueça", subtitle: "Mimimi", body: "mimimimimimimimimimimim mimimii"),
                                NotificationContent.init(title: "Cafééééé'é", subtitle: "Mimimi", body: "mimimimimimimimimimimim mimimii"),
                                NotificationContent.init(title: "hihi", subtitle: "Mimimi", body: "mimimimimimimimimimimim mimimii"),
                                NotificationContent.init(title: "ajshkahsooowowow", subtitle: "Mimimi", body: "mimimimimimimimimimimim mimimii")]
    func triggerNofication(){
        
        let randomNumber = Int(arc4random_uniform(UInt32(notificationContents.count)))
        let notificationContent = notificationContents[randomNumber]
        
        let content = UNMutableNotificationContent()
        content.title = notificationContent.title
        content.subtitle = notificationContent.subtitile
        content.body = notificationContent.body
        
        var date = DateComponents()
        date.hour = 12
        date.minute = 16
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request,
                                               withCompletionHandler: { (error) in
                                                // Handle error
        })
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
