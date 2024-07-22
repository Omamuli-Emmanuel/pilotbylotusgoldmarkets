import UIKit
import Flutter
//import Firebase
//import FirebaseMessaging
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Initialize Firebase
    FirebaseApp.configure()
    
    // Register for push notifications
    registerForPushNotifications(application)
    
    // Call the super class's implementationå
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Register for push notifications
  private func registerForPushNotifications(_ application: UIApplication) {
    UNUserNotificationCenter.current().requestAuthorization(
      options: [.alert, .badge, .sound]
    ) { granted, error in
      if granted {
        DispatchQueue.main.async {
          application.registerForRemoteNotifications()
        }
      } else if let error = error {
        print("Error requesting push notification permissions: \(error.localizedDescription)")
      }
    }
    
    UNUserNotificationCenter.current().delegate = self
  }
  
  // Handle incoming notifications while the app is in the foreground
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    completionHandler([.alert, .badge, .sound])
  }
  
  // Handle the registration of the device token
  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    Messaging.messaging().apnsToken = deviceToken
  }
  
  // Handle errors related to push notification registration
  override func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("Failed to register for remote notifications: \(error.localizedDescription)")
  }
}
