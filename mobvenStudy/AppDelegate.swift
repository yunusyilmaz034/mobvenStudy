//
//  AppDelegate.swift
//  mobvenStudy
//
//  Created by YUNUS YILMAZ on 12.01.2018.
//  Copyright © 2018 YUNUS YILMAZ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var plistPathDocuments: String = String()
    
    func preparePlistForUse() {
        let rootpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)[0]
        plistPathDocuments = rootpath + "/historySearch.plist"
        
        if !FileManager.default.fileExists(atPath: plistPathDocuments){
            let plistPathInBundle = Bundle.main.path(forResource: "historySearch", ofType: "plist") as String!
            do {
                try FileManager.default.copyItem(atPath: plistPathInBundle!, toPath: plistPathDocuments)
            } catch {
                print(error)
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        preparePlistForUse()
        
        let splitViewController = window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = self
        
        UISearchBar.appearance().tintColor = .cityGreen
        UINavigationBar.appearance().tintColor = .cityGreen
        
        
        return true
    }

    // MARK: - Split view
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailCity == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        preparePlistForUse()
    }

}

