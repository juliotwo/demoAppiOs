//
//  AppDelegate.swift
//  PlatziFinanzas
//
//  Created by Andres Silva on 11/14/18.
//  Copyright © 2018 Platzi. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
    var window: UIWindow?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        
        SignInViewModel.googleLogin(user: user) { [weak self] (succes, error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                return
            }
            
            if succes {
                self?.window = UIWindow(frame: UIScreen.main.bounds)
                let name = "Main"
                let viewController = UIStoryboard(name: name, bundle: Bundle.main).instantiateInitialViewController()
                self?.window?.rootViewController = viewController
                self?.window?.makeKeyAndVisible()
                
            }
        }
  
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print(error)
    }
    

   


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let _ = LocalNotificationController()
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        initialViewController()
        return true
    }
    func initialViewController() {
        
        let onboaring = UserDefaults.standard.value(forKey: "WatchedOnboarding") as? Bool ?? false
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        var name = "OnBoarding"
        
        if onboaring {
            name = "SignIn"
        }
        let session = Auth.auth().currentUser != nil
        if session{
            name = "Main"
        }
        let viewController = UIStoryboard(name: name, bundle: Bundle.main).instantiateInitialViewController()
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if FBSDKApplicationDelegate.sharedInstance()?.application(app, open: url, options: options) ?? false {
            return true
        }
        if  GIDSignIn.sharedInstance()?.handle(url,                               sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                               annotation: [:]) ?? false{
            return true
        }
        return true
    }


}

