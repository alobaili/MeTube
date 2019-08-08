//
//  AppDelegate.swift
//  MeTube
//
//  Created by Abdulaziz AlObaili on 07/08/2019.
//  Copyright © 2019 Abdulaziz Alobaili. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let flowlayout = UICollectionViewFlowLayout()
        let homeController = HomeController(collectionViewLayout: flowlayout)
        
        window?.rootViewController = UINavigationController(rootViewController: homeController)
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 230/255, green: 32/255, blue: 31/255, alpha: 1)
        
        // remove the thin line between the navigation bar and the menu bar view bellow it.
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.backgroundColor = UIColor(red: 194/255, green: 31/255, blue: 31/255, alpha: 1)
        window?.addSubview(statusBarBackgroundView)
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusBarBackgroundView.topAnchor.constraint(equalTo: window!.topAnchor),
            statusBarBackgroundView.leadingAnchor.constraint(equalTo: window!.leadingAnchor),
            statusBarBackgroundView.trailingAnchor.constraint(equalTo: window!.trailingAnchor),
            statusBarBackgroundView.bottomAnchor.constraint(equalTo: window!.safeAreaLayoutGuide.topAnchor)
        ])
        
        return true
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


}

