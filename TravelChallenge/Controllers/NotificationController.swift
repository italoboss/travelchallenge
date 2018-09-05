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

    let notificationContents = [NotificationContent.init(title: "Não esqueça de economizar", subtitle: "", body: "Se você não comprar nada o desconto é bem maior."),
                                NotificationContent.init(title: "Quer saber o que é mágica?", subtitle: "", body: "Trabalho sete dias por semana e todo dia meu dinheiro desaparece. Isso que é mágica"),
                                NotificationContent.init(title: "Você não precisa gastar muito dinheiro com roupas", subtitle: "", body: "Quando eu era garoto não precisava de roupa especial, ter roupa já era especial."),
                                NotificationContent.init(title: "Não esqueça de economizar", subtitle: "Faça a pergunta mágica quando for comprar o almoço:", body: "Aceita vale-refeição?”"),
                                NotificationContent.init(title: "Desligue o relógio", subtitle: "Você não precisa ver as horas enquanto dorme", body: "São 2 centavos por hora!"),
                                NotificationContent.init(title: "Não esqueça de economizar", subtitle: "Achou que eu estava brincando?", body: "Quando estiver no chuveiro, eu vou estar lá. Quando estiver vendo TV, eu vou estar lá. Quando estiver sonhando, eu vou estar lá.")]
    func triggerNofication(){
        
        let randomNumber = Int(arc4random_uniform(UInt32(notificationContents.count)))
        let notificationContent = notificationContents[randomNumber]
        
        let content = UNMutableNotificationContent()
        content.title = notificationContent.title
        content.subtitle = notificationContent.subtitile
        content.body = notificationContent.body
        
        var date = DateComponents()
        date.hour = 9
        date.minute = 00
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
