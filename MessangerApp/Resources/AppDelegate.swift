//
//  AppDelegate.swift
//  MessangerApp
//
//  Created by 野澤拓己 on 2020/11/21.
//


// Swift // // AppDelegate.swift
import UIKit
import Firebase
import FBSDKCoreKit
@UIApplicationMain

class AppDelegate:UIResponder, UIApplicationDelegate {
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        
        FirebaseApp.configure()
        
        return true
        
    }
    func application( _ app:UIApplication, open url:URL, options: [UIApplication.OpenURLOptionsKey :Any] = [:] ) -> Bool {
        
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )

    }
}


