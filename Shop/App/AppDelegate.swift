//
//  AppDelegate.swift
//  Shop
//
//  Created by Juliano Terres on 19/11/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    createStartScreen()
    return true
  }
  
  private func createStartScreen() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = AppFactory.create()
    window?.makeKeyAndVisible()
  }
}
