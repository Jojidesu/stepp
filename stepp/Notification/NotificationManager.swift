//
//  File.swift
//  stepp
//
//  Created by Giorgy null on 17/10/21.
//

import Foundation
import UserNotifications

protocol Notifying {
  func sendNotification(title: String, subtitle: String)
}

class NotificationManager: Notifying {
  func sendNotification(title: String, subtitle: String) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
      let content = UNMutableNotificationContent()
      content.title = title
      content.subtitle = subtitle
      content.sound = UNNotificationSound.default
      let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
      let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
      UNUserNotificationCenter.current().add(request) { (error) in
        print(error ?? "eh")
      }
    }
  }
}
