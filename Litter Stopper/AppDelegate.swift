//
//  AppDelegate.swift
//  Litter Stopper
//
//  Created by Applr on 13/08/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ClockTimer :Timer!
    var timerSecond :Int!
    var passDetailsModel1 : aboutCleanModel!
    var PassDetailsModel2 : SaveItemDetailsModel!
    var PassdetailsModel3 : SaveTimeAndEffortContentModel!
    var PassdetailsFullAudit : SaveItemFullAuditCleanModel!
    var PassDetailsPartialAudit : SaveItempartialAuditCleanModel!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        timerSecond = 0
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        setupMainController()
        //Setup Window Color
        window?.backgroundColor=UIColor.white
        self.window?.makeKeyAndVisible()
        Fabric.with([Crashlytics.self])
        
        passDetailsModel1 = aboutCleanModel.init()
        PassDetailsModel2 = SaveItemDetailsModel.init()
        PassdetailsModel3 = SaveTimeAndEffortContentModel.init()
        PassdetailsFullAudit = SaveItemFullAuditCleanModel.init()
        PassDetailsPartialAudit = SaveItempartialAuditCleanModel.init()
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
        if AppDelegate.sharedDelegate.ClockTimer != nil{
            AppDelegate.sharedDelegate.ClockTimer.invalidate()
        }
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    class var sharedDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func getViewControllerFromCustomer(viewControllerName identifier : String)->AnyObject{
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller:AnyObject = storyBoard.instantiateViewController(withIdentifier: identifier)as AnyObject
        return controller
        
    }
    func setupMainController(){
        if isWalkThroughRead {
            let homeNaigation  = getViewControllerFromCustomer(viewControllerName: "HomeNavigation") as! UINavigationController
            self.window?.rootViewController = homeNaigation
        }else{
            
        }
    }

}

