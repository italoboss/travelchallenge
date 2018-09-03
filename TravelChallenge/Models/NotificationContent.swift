//
//  NotificationContent.swift
//  TravelChallenge
//
//  Created by Ada 2018 on 03/09/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import Foundation

struct NotificationContent {
    let title: String
    let subtitile: String
    let body: String
    
    init(title: String, subtitle: String, body: String){
        self.title = title
        self.subtitile = subtitle
        self.body = body
    }
}
