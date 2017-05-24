//
//  ViewController.swift
//  NewNotifications
//
//  Created by Aman Vaid on 5/23/17.
//  Copyright © 2017 Aman Vaid. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //1. Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if granted {
                print("Notification Access Granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    }
    
    @IBAction func notifyButtonTapped(sender: UIButton){
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        //Add attachment
        let myImage = "superman3"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "jpg") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        //Only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "What is that?!"
        notif.subtitle = "Up in the sky?"
        notif.body = "Is it a bird. Is it a plane? ... NO! It's Superman!"
        
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        
        })
    }
}

