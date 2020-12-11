//
//  AppDelegate.swift
//  FirebaseAuthTest
//
//  Created by Ranula Ranatunga on 8/25/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        ApplicationService.shared.manageUserDirection(window: window)
        
//        let userDefaultId = Auth.auth().currentUser?.uid
//        let userFirebaseKey = UserDefaults.standard.string(forKey: "firebase-user-key")
//
//        if userDefaultId == userFirebaseKey {
//            //print(userDefaultId == userFirebaseKey)
//            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let home = mainStoryboard.instantiateViewController(withIdentifier: "home") as! HomeVC
//            self.window?.rootViewController = home
//        } else {
//            //try! Auth.auth().signOut()
//            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let login = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginVC
//            self.window?.rootViewController = login
//        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
     func setAsRoot(_controller: UIViewController) {
           if window != nil {
               window?.rootViewController = _controller
           }
       }

}

