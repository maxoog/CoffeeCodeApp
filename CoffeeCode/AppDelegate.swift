import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import AppMetricaPlatform
import AppMetricaCore

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    static let shared = AppDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // MARK: - Настройка Firebase
        FirebaseApp.configure()
        Auth.auth().languageCode = "ru-RU";
        
        // MARK: - Настройка App Metrica
        guard let configuration = AMAAppMetricaConfiguration(apiKey: "257a9ddd-29da-496d-b359-1cbe2fc09749")else {
            assertionFailure("Invalid App Metrica Configuration!")
            return true
        }
        AMAAppMetrica.activate(with: configuration)
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        AMAAppMetrica.reportEvent(
            name: "Запуск приложения",
            parameters: ["Пользователь": "test_maxood"]
        )
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: .prod)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}
    
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification notification: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult
    ) -> Void) {
        // This notification is not auth related; it should be handled separately.
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

