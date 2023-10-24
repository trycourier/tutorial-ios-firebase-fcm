//
//  AppDelegate.swift
//  Courier iOS Firebase
//
//  Created by Carter Rabasa on 10/23/23.
//

import Courier_iOS
import SwiftUI
import FirebaseCore
import FirebaseMessaging

class AppDelegate: CourierDelegate, MessagingDelegate {
    
    private var firebaseMessaging: Messaging {
        get {
            return Messaging.messaging()
        }
    }
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        firebaseMessaging.delegate = self
        
        return true
        
    }
    
    override func deviceTokenDidChange(rawApnsToken: Data, isDebugging: Bool) {
        
        firebaseMessaging.setAPNSToken(rawApnsToken, type: isDebugging ? .sandbox : .prod)
        
    }
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        guard let token = fcmToken else { return }
        
        Task {
            do {
                try await Courier.shared.setFCMToken(token)
            } catch {
                print(String(describing: error))
            }
        }
        
    }
    
    override func pushNotificationDeliveredInForeground(message: [AnyHashable : Any]) -> UNNotificationPresentationOptions {
        
        print("\n=== 💌 Push Notification Delivered In Foreground ===\n")
        print(message)
        print("\n=================================================\n")
        
        // This is how you want to show your notification in the foreground.
        // Pass "[]" if you don’t want to show the notification to the user, or
        // you can handle this using your own custom styles
        return [.sound, .list, .banner, .badge]
        
    }

    override func pushNotificationClicked(message: [AnyHashable : Any]) {
        
        print("\n=== 👉 Push Notification Clicked ===\n")
        print(message)
        print("\n=================================\n")
        
    }
    
}
