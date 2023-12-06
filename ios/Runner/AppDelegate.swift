import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
            if granted {}
            else if let error = error {
               print("Error al solicitar permisos de notificaciones: \(error)")
            }
        }
    } else {
        let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

