//
//  AppDelegate.swift
//  Proiect
//
//  Created by Roxana Andreea on 06/04/2020.
//  Copyright © 2020 Roxana Andreea. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let gameViewController = GameViewController()
        window?.rootViewController = gameViewController
        
        ActionsManager.shared.launch()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
       // UserDefaults.standard.set(ActionsManager.shared.lastBoard, forKey: "board")
    }

    func saveBoard() {
        let board = ActionsManager.shared.lastBoard
 
        UserDefaults.standard.set(board?.values, forKey: "values")
        UserDefaults.standard.set(board?.stringState, forKey: "correct")
        UserDefaults.standard.set(board?.canModify, forKey: "canModify")
        print("board succesfully saved in memory ....................")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        
       // ActionsManager.shared.eraseGameFromMemory()
        saveBoard()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

  

}

