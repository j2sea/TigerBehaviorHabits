import UIKit
import AppsFlyerLib
import AppTrackingTransparency
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, AppsFlyerLibDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let apps = AppsFlyerLib.shared()
        apps.appleAppID = "6737608775"
        apps.appsFlyerDevKey = "R9CH5Z" + "s5bytFgTj6smkgG8" + ""
        apps.delegate = self
        apps.waitForATTUserAuthorization(timeoutInterval: 15)

        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)

        initPush()
        
        // firebase
        FirebaseApp.configure()
        
        if UIViewController.shouldUnzip() {
            UIViewController.unzipQuzi()
        }
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    func initPush() {
        // push
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        UIApplication.shared.registerForRemoteNotifications()
    }

    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.45) {
            if #available(iOS 14, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        debugPrint(userInfo)
        completionHandler([[.sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        debugPrint(userInfo)
        completionHandler()
    }
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        debugPrint("success appsflyer")
    }
    
    func onConversionDataFail(_ error: Error) {
        debugPrint("error appsflyer")
    }
}
