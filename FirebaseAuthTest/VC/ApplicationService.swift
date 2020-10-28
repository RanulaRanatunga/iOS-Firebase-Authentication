//
//  ApplicationService.swift
//  iOS_Developer_Test
//
//  Created by Ranula Ranatunga on 6/15/20.
//  Copyright © 2020 Ranula Ranatunga. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import FirebaseAuth

class ApplicationService {
    
    static let shared = ApplicationService()
    
    let bundleId = Bundle.main.bundleIdentifier ?? ""
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let deviceType = "APPLE"
    
    private init() {}
    
    func configure() {
        manageUIAppearance()
        printRealmPath()
    }
    
    func setupAccessToken() {
    //guard let user = LocalUser.current() else {
    //return
    //}
    //SwaggerClientAPI.customHeaders.updateValue(user.accessToken, forKey: "x-access-token")
    }
    
    private func manageUIAppearance() {
        // Set navigation bar tint / background color
        UINavigationBar.appearance().isTranslucent = false
        
        // Set navigation bar item tint color
        UIBarButtonItem.appearance().tintColor = .darkGray
        
        // Set navigation bar back button tint color
        UINavigationBar.appearance().tintColor = .darkGray
        
        // Set back button image
//        let backImage = UIImage(named: "ic_back")
//        UINavigationBar.appearance().backIndicatorImage = backImage
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        
        // To remove the 1px seperator at the bottom of navigation bar
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    private func printRealmPath() {
        print("Realm path: \(String(describing: try! Realm().configuration.fileURL))")
    }
    
    //MARK: Manage User Direction
    public func manageUserDirection(from vc: UIViewController? = nil, window: UIWindow? = nil) {
        guard Auth.auth().currentUser?.uid != nil else {
            directToPath(in: "Main", for: "login", from: vc, window: window)
            return
        }
        // Set access token to SwaggerClientAPI.customHeaders and iBaseSwift AppConstant.customHeaders
//        setupAccessToken()
        getRedirectionWithMainInterfaceType( window: window)
    }
    
    
    //MARK: Get ridirection with app main interface type
    func getRedirectionWithMainInterfaceType(from vc: UIViewController? = nil, window: UIWindow? = nil) {
        
            directToPath(in: "Main", for: "home", from: vc, window: window)
       
    }
    
    
    //MARK: Direct to Main Root window
    public func directToPath(in sb: String, for identifier: String, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        let storyboard = UIStoryboard(name: sb, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        appDelegate.setAsRoot(_controller: topController)
    }
    
//    public func manageUserDirection(window: UIWindow? = nil) {
//        let userDefaultId = Auth.auth().currentUser?.uid
//        let userFirebaseKey = UserDefaults.standard.string(forKey: "firebase-user-key")
//
//
//        if userDefaultId == userFirebaseKey {
//            print(userDefaultId == userFirebaseKey)
//            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let home = mainStoryboard.instantiateViewController(withIdentifier: "home") as! HomeVC
//            window?.rootViewController = home
//        } else {
//            //try! Auth.auth().signOut()
//            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let login = mainStoryboard.instantiateViewController(withIdentifier: "login") as! LoginVC
//            window?.rootViewController = login
//        }
//    }
//
}
